# Stardew Valley Multiplayer Docker Compose (SVE Enabled)

This project aims to autostart a Stardew Valley Multiplayer Server as easily as possible using Docker Compose. It is a forked version of [printfuck/stardew-multiplayer-docker](https://github.com/printfuck/stardew-multiplayer-docker) with additional mods and optimizations for personal use.

## Features

- Easy setup and deployment using Docker Compose
- Supports Stardew Valley Expanded (SVE) and other important mods
- Autoload functionality to resume the last saved game
- Accessible via VNC or web interface
- Customizable settings through environment variables

## Prerequisites

- Docker and Docker Compose installed on your system
- A copy of Stardew Valley (the game will be pulled from the server during the build process)

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/indifferentketchup/stardew-multiplayer-docker.git
   ```
2. Navigate to the cloned directory:

   ```bash
   cd stardew-multiplayer-docker
   ```

3. Start the server using Docker Compose:

   ```bash
   docker-compose up
   ```

4. Access the game via VNC or the web interface (see the "Accessing the Game" section below).

## Configuration

You can customize the server settings by modifying the `docker-compose.yml` file. Some notable options include:

- `VNCPASS`: Set the password for the VNC server (default: "insecure")
- `AUTOLOAD_SAVE_NAME`: Specify the name of the save game to autoload (default: none)

## Accessing the Game

### VNC

Use a VNC client like TightVNC on Windows or `vncviewer` on Linux to connect to the server. The VNC port and password can be modified in the `docker-compose.yml` file.

### Web Interface

The server exposes a web interface on port 5800 inside the container. Although it requires the VNC password, it is not recommended to expose this port to the outside world.

## Important Mods

This project includes the following important mods:

1. **Stardew Valley Expanded (SVE)**: A major expansion mod that adds new locations, NPCs, events, and more to the game.
2. **East Scarp**: Adds a new eastern region to the game with unique locations and characters.
3. **Always Raining in the Valley**: Makes it rain all the time in Stardew Valley, creating a unique atmosphere.
4. **Downtown Zuzu**: Introduces a new city area called Downtown Zuzu with various shops and activities.
5. **Adventurer's Guild Expanded**: Expands the Adventurer's Guild with new quests, rewards, and features.
6. **Immersive Farm 2 Remastered**: Overhauls the standard farm layout to provide a more immersive and realistic farming experience.
7. **StardewAquarium**: Allows players to build and manage their own aquarium, displaying various fish and aquatic creatures.
8. **AnimalHusbandryMod**: Adds more depth to animal husbandry, including new animals, products, and interactions.
9. **LoveOfCooking**: Introduces a cooking skill system and new recipes to the game.
10. **Better Quarry Redux**: Improves the quarry area with new features and mining opportunities.
11. **Always On Server**: Keeps the server running even when no players are connected.
12. **AutomaticGates**: Automatically opens and closes gates when the player approaches them.
13. **BetterChests**: Adds additional functionality and customization options for chests.
14. **BetterRanching**: Improves the ranching experience with new features and quality of life improvements.
15. **BetterWorkbenches**: Enhances the workbench functionality and adds new recipes.
16. **ConsoleCommands**: Provides a set of console commands for server administrators.
17. **DedicatedServer**: Optimizes the game for running as a dedicated server.
18. **DeepWoodsMod**: Adds a new forest area to explore with unique features and challenges.
19. **ExpandedStorage**: Increases the storage capacity of chests and other containers.
20. **NPCMapLocations**: Shows the locations of NPCs on the map.
21. **SaveBackup**: Automatically creates backups of save files to prevent data loss.
22. **TimeSpeed**: Allows players to adjust the speed of time in the game.
23. **UnlimitedPlayers**: Removes the player limit, allowing more than four players to join the server.
24. **Seasonal Cute Characters**: Adds seasonal outfits and appearances for characters, enhancing the game's visual appeal.

Please refer to each mod's documentation for specific installation, configuration, and usage instructions.

## Troubleshooting

- If you encounter any error messages in the console, look for messages like "cannot open display", which may indicate permission errors.
- If the game doesn't start, access it via VNC to initially load or start a pre-generated save game.
- For optimal performance, it is recommended to use a VPS/machine with at least four logical CPUs and 4GB RAM. The minimum playable configuration for 2-4 players is two logical CPUs and 1GB RAM.

## Contributing

Pull requests and suggestions for improvements are welcome! If you encounter any issues or have ideas for enhancements, please open an issue on the GitHub repository.
