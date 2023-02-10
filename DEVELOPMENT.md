# Development

Feel free to customise the modules as you desire. Obviously, if there are any updates it might affect your changes.


## Files

`/init.sh` - Called by zsh_profile when new profile is loaded or a reload / update command is executed.

### Directories
`/configs` - Module configuration files that can be ignored by the user.
`/documnetation` - Information about each module.
`/modules` - The actual code for each module.


## Development Rules
1. Keep all modules code within the relevent module file.
2. Modules should be named the same as the command, with hypens used as sapces.
2. Ensure modules are easy and simple to use.
3. Ensure that any stateful variables are kept in `/configs`.
4. Ensure documnetation is created for any new modules and it is kept up-to-date. Author tags let us know who to ask if something isn't working as expected.
5. Update `/CHANGELOG.md` & `/VERSION` as appropriate.
6. If calling a command that is also in the module, use `command` before the call. This will call the command directly. Example: `/modules/git.sh`.
7. Test code fully before releasing it - nobody wants errors.
8. No viruses or hacking.
