# CLAUDE.md

このリポジトリには絶対に AI によるコードを書かないこと。オブジェクト指向プログラミングを理解するためのもののため、必ず直接コードに手を加えるのではなく、理解に必要なアドバイスをしてください。

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Running the Project

Run the main Pokemon battle simulation:

```bash
ruby main.rb
```

Install dependencies:

```bash
bundle install
```

## Architecture Overview

This is a Ruby-based Pokemon battle simulator with Japanese text output. The architecture separates concerns into distinct layers:

### Pokemon Class Hierarchy

- **Base Class**: `Pokemon` (pokemon/pokemon.rb) - Defines name, type, and moves
- **Type-Specific Classes**: `FirePokemon`, `WaterPokemon`, `GrassPokemon` - Inherit from Pokemon and define special moves
  - FirePokemon: special_move returns "かえんほうしゃ" (Flamethrower)
  - WaterPokemon: special_move returns "ハイドロポンプ" (Hydro Pump)
  - GrassPokemon: special_move returns "ソーラービーム" (Solar Beam)

### Pokemon State Wrappers

The codebase uses two wrapper classes to represent different contexts:

- **PlayerPokemon** (pokemon/player_pokemon.rb) - Wraps a Pokemon with player-specific attributes (level, HP, moves). This represents a Pokemon that has been "caught" by the player.
- **BattlePokemon** (pokemon/battle_pokemon.rb) - Represents a Pokemon in battle context with HP tracking and damage calculation. Created from PlayerPokemon or directly for enemy Pokemon. Contains methods: `special_move()`, `is_alive?()`, `status()`, `take_damage(damage)`.

### Battle System

- **Battle Class** (battle/battle.rb) - Manages battle flow using a state machine
- **BattleStatus Module** (battle/battle_status.rb) - Defines battle states as constants:
  - START (0) → SELECT_MOVE (1) → ATTACK (2) → BE_ATTACKED (3) → DECIDE_WINNER (4) or back to SELECT_MOVE

Battle flow:

1. `introduction()` - Returns initial status messages
2. `select_move()` - Currently a placeholder (TODO: implement move selection)
3. `player_attack()` / `enemy_attack()` - Execute attacks and return result messages
4. `battle_in_progress?()` - Returns false when status is DECIDE_WINNER

The Battle class manages state transitions via `go_to_next_status()` and determines when battles end via `battle_over?()`.

### UI Layer

- **Serif Class** (serif.rb) - Utility class using tty-prompt for text output
  - `Serif.say(message)` - Display text
  - `Serif.next(message)` - Wait for keypress to continue

## Key Implementation Details

- All text output is in Japanese
- Damage calculation is randomized: `rand(10..25)` in battle/battle.rb:68
- BattlePokemon currently only uses the first move from the moves array (battle_pokemon.rb:13)
- Move selection is not yet implemented (battle.rb:31 has TODO comment)

## Dependencies

- `tty-prompt` - Used for interactive CLI prompts and output (Gemfile, serif.rb)
