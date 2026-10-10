# KJVVerses

**KJVVerses** is a lightweight World of Warcraft **Classic Era** addon that displays rotating Bible verses from the **King James Version (KJV)** in a customizable on-screen panel.

> Displays rotating King James Version (KJV) Bible verses in a customizable, unobtrusive panel while you explore Azeroth.

## Features

- 50 selected KJV Scripture passages displayed with their references
- Automatic, sequential rotation (default: every 2 minutes)
- Rotation interval choices: 30 seconds, 1 minute, 2 minutes, 5 minutes, or 10 minutes
- Next/previous verse controls; pause and resume rotation
- Move and resize the panel when unlocked
- Adjustable minimum height, automatic text wrapping, and expansion for long passages
- Adjustable background opacity, font size, and six text-color presets
- Gold Scripture references, regardless of selected verse-text color
- Saved layout and preferences, plus a one-time welcome message

## Compatibility

- **World of Warcraft Classic Era**, tested by the developer on client **1.15.9** (interface `11509`).
- This package is **not** designated for Retail or progression Classic clients.

## Installation (manual)

1. Download the ZIP from the project's **Releases** page.
2. Extract it, keeping the `KJVVerses` folder intact.
3. Place the folder in your WoW Classic Era addons directory, usually:
   `World of Warcraft/_classic_era_/Interface/AddOns/KJVVerses/`
4. Confirm that `KJVVerses.toc` and `KJVVerses.lua` are directly inside that folder (not nested in a second `KJVVerses` directory).
5. Enable **KJVVerses** at the character selection **AddOns** screen and enter the game.
6. Type `/kjv` to open settings.

## Commands

| Command | Description |
| --- | --- |
| `/kjv` | Toggle settings window |
| `/kjv config` | Open settings |
| `/kjv next` | Next passage; restart timer if running |
| `/kjv prev` | Previous passage; restart timer if running |
| `/kjv pause` | Pause automatic rotation |
| `/kjv resume` | Resume with a fresh rotation countdown |
| `/kjv interval 30` | Rotate every 30 seconds (also accepts `60`, `120`, `300`, `600`) |
| `/kjv show` | Show the panel |
| `/kjv hide` | Hide panel; rotation continues |
| `/kjv unlock` | Enable dragging and resizing |
| `/kjv lock` | Disable dragging and resizing |
| `/kjv reset` | Show reset confirmation instructions |
| `/kjv reset confirm` | Reset layout and appearance |
| `/kjv help` | Show in-game command help |

## Customization

Use `/kjv` for panel width, minimum height, opacity, font size, text color, and rotation interval. Unlock the panel before dragging it or using the resize grip. Changes save via `KJVVersesDB` in the game's SavedVariables system. The panel may grow taller than your selected minimum height to fit a long passage.

**Note:** Pausing rotation lasts until you resume or reload; it is not saved across game sessions.

## Reporting issues

Open a GitHub issue with your WoW Classic Era client version, steps to reproduce, and any in-game Lua error message. Screenshots are welcome. Please avoid including personal information or your `WTF` folder.

## Scripture and attribution

Scripture excerpts are from the **King James Version (KJV)** of the Bible. KJVVerses is a community-developed, free addon and is not affiliated with or endorsed by Blizzard Entertainment.

## License

KJVVerses is open-source software licensed under the MIT License.

You are free to use, modify, and distribute the addon in accordance with the terms of the license. See the LICENSE file for details.

Scripture quotations are from the King James Version (KJV) of the Bible, which is in the public domain in the United States. Rights to the KJV are subject to separate restrictions in certain jurisdictions, including the United Kingdom.

The MIT License applies to the addon's original source code and does not alter any applicable rights associated with the Scripture text.
