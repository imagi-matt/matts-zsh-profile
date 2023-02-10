# Matt's ZSH Profile Improvements
A repo for managing and sharing zsh profile changes.

These changes can affect existing functionality, so ensure you understand commands that piggyback of existing commands. Note: when piggybacking - no existing functionality should become dangerous if run.

## Requirements
- macOS Big Sur (11.4) <=
- ZShell profile


## Install
To install:
1. Clone repo to `~/.zsh_profile.d`
2. Run `compaudit`, if no errors continue to 3.
   1. If errors, see autocomplete below.
3. Run `./_install_.sh` from the root of the repo


## Configuration
The only file the user needs to modify is `enabled.ini`.
To active a module change the number to `1`, to de-activate change to `0`.

Modules are loaded dynamically based on the contents of `enabled.ini`.
If too many modules are coming up, you can remove or comment out a module (leading character: `#`, `//`, `;`, etc.).
If a new module is released it doesn't get automatically added.


## Modules
Each module has it's own documentation in the `Documentation` directory.


## Development / Advanced Customisation
See `DEVELOPMENT.md` for additional information.


## Autocompletion
ZShell is able to analysis commands and provide autocompletion without requiring additional files.
This can be disabled by commenting out the `autoload` line in `_ini_.sh`

This can cause problems if there are incorrect permissions set.

 and remove any write permissions to the group like:

    chmod g-w /usr/local/share/zsh/site-functions

Once `compaudit` returns no errors, you can install again.


## Maintainer
Matt - matt@imagi.cloud
