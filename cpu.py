import csv
import numpy as np

FIELD_SIZE = 10
map_field = np.zeros((FIELD_SIZE, FIELD_SIZE))

# Initial position and direction of the robot
robot_pos = [0, 0]  # Starting in the corner (0,0)
directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # N, E, S, W
current_direction = 0  # Start facing North (0,1)

def turn_robot(degrees):
    global current_direction
    # Each turn changes the direction index
    steps = degrees // 90
    current_direction = (current_direction + steps) % 4

def move_robot(blocks):
    global robot_pos
    dx, dy = directions[current_direction]
    new_pos = [robot_pos[0] + dx * blocks, robot_pos[1] + dy * blocks]
    # Check for boundaries
    if 0 <= new_pos[0] < FIELD_SIZE and 0 <= new_pos[1] < FIELD_SIZE:
        robot_pos = new_pos
    else:
        raise ValueError("Illegal instruction: move out of bounds")

def do_instruction(inst):
    command, value = inst
    if command == "MOV":
        move_robot(int(value))
    elif command == "TURN":
        turn_robot(int(value))
    else:
        raise ValueError(f"Illegal instruction: {command}")
    # For visualization, mark the robot's current position
    map_field[robot_pos[0], robot_pos[1]] = 1

def read_file(filename):
    inst_list = []
    with open(filename) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            inst_list.append(row)
    return inst_list

def main():
    print("Starting Robot Simulation")
    inst_list = read_file('instructions.asm')
    for inst in inst_list:
        try:
            do_instruction(inst)
        except ValueError as e:
            print(e)
            break
    print("Final State of the Field:")
    print(map_field)

if __name__ == "__main__":
    main()
