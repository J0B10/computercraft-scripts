## How to use Git Download

To run Git Download type the command **`gd`** in your computers shell.

On first use the program will ask for a base url for the repository to use: 
```
Repositpory not set.
Please specify the base url for all raw files:
> 
```
You'll need to specify a url where the **raw** files containing the code can be found.  
For this repository it would be the following url, to use your own repo just replace the username and repository name with your own one and make sure it's the right branch.  
```
https://raw.githubusercontent.com/joblo2213/computercraft-scripts/master/

```

From now on you'll be only asked for a relative path to a file from the repository root:

```
Please specify a file from the repo to download.
>
```
For convenience all `\` characters in the file name will be replaced with `/`.  

**Example:** [`ftbiesem/autocraft.lua`](https://github.com/joblo2213/computercraft-scripts/blob/master/ftbiesem/autocraft.lua)

After the file path you'll be asked for the name under which the file should be stored on the computer. If you don't specify a name and press enter `startup` will be used as default name so the program is automatically run on startup.
```
Please specify a name for the programm (default: startup)
> 
```
If the program does already exist you must confirm overriding with `Y` (or by just pressing enter, which is way faster).

The program will then be downloaded and saved on your computer. 

If you want to change the base repository path at any point you can use the command `edit .gd.cfg` to edit the config.

You can also do all this in one single command without any prompts if you prefer it that way:
```
gd [relative file path] [file name]
```