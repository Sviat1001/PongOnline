# This is Pong Online - my first game, and the first game out of the [20 games challenge](https://20_games_challenge.gitlab.io/challenge/)

## Installation Guide

There are two ways to play this game

### 1. Download the executable

From Executables folder of the repository, download the executable for the Operating System
and processor architecture of your system, or the contents of Web folder for Web version.

For the Web application to work, it is needed to create a web server.
A python script PongOnline.py is included in the Web, which opens the game as a browser tab.

### 2. Build from source

#### Prerequisites

To build the game from project files,
it is required to install Godot Engine and the export templates

[Godot Engine and export templates download page](https://godotengine.org/download/)

**Note:** in order to build a Web application, the version without .NET support is required

#### Steps

1. Donwload a Project folder from the repository;
2. Donwload Godot Project and export templates;
3. Open Godot Engine, and open a downloaded project;
4. After opening a project, in the tab "Project" choose the option "Export...";
5. Choose a platform, and export a project.

**Note** when exporting for the first time, it is required to install export templates

For more information about exporting projects in Godot Engine, click [here](https://docs.godotengine.org/en/stable/tutorials/export/index.html)

## Controls

In Single player mode, the paddle can be moved by pressing UP and DOWN keys, or by pressing W and S keys.

In Two Player mode, the left paddle is moved by pressing W and S keys, 
and the right paddle is moved by pressing UP and DOWN keys.

To pause the game, press Esc key.
