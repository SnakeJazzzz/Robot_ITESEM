import tkinter as tk
import csv
import time
import numpy as np

FIELD_SIZE = 20  # Size of the grid
CELL_SIZE = 50  # Pixel size of each grid cell
COLORS = ["red", "green", "blue", "yellow", "magenta", "cyan"]  # List of colors for each move

# Initial position and direction of the robot
robot_pos = [0, 0]  # Starting in the corner (0,0)
directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # N, E, S, W
current_direction = 0  # Start facing North (0,1)

class RobotSimulator(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Robot Path Simulator")
        self.canvas = tk.Canvas(self, width=FIELD_SIZE*CELL_SIZE, height=FIELD_SIZE*CELL_SIZE)
        self.canvas.pack()
        self.draw_grid()
        self.move_count = 0  # Count each move to change colors

    def draw_grid(self):
        for i in range(FIELD_SIZE):
            for j in range(FIELD_SIZE):
                self.canvas.create_rectangle(i*CELL_SIZE, j*CELL_SIZE, (i+1)*CELL_SIZE, (j+1)*CELL_SIZE, fill="white")

    def update_position(self, new_pos, color_index):
        color = COLORS[color_index % len(COLORS)]  # Use the current move's color
        self.canvas.create_rectangle(new_pos[0]*CELL_SIZE, new_pos[1]*CELL_SIZE, (new_pos[0]+1)*CELL_SIZE, (new_pos[1]+1)*CELL_SIZE, fill=color)
        self.update()  # Update the canvas
        time.sleep(1)  # Wait for 1 second to visualize the move

def turn_robot(degrees):
    global current_direction
    steps = degrees // 90
    current_direction = (current_direction + steps) % 4

def move_robot(blocks, app, color_index):
    global robot_pos
    dx, dy = directions[current_direction]
    for _ in range(blocks):
        robot_pos[0] += dx
        robot_pos[1] += dy
        # Check for boundaries
        if not (0 <= robot_pos[0] < FIELD_SIZE) or not (0 <= robot_pos[1] < FIELD_SIZE):
            raise ValueError("Illegal instruction: move out of bounds")
        app.update_position(robot_pos, color_index)

def do_instruction(inst, app):
    global robot_pos
    command, value = inst
    if command == "MOV":
        move_robot(int(value), app, app.move_count)
    elif command == "TURN":
        turn_robot(int(value))
    app.move_count += 1  # Increment move_count here after processing a command

def read_file(filename):
    inst_list = []
    with open(filename) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            inst_list.append(row)
    return inst_list

def main():
    app = RobotSimulator()
    inst_list = read_file('instructions.asm')
    for inst in inst_list:
        try:
            do_instruction(inst, app)
        except ValueError as e:
            print(e)
            break
    app.mainloop()

if __name__ == "__main__":
    main()

