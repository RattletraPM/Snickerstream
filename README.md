# Snickerstream

Snickerstream is a streaming client for Nintendo 3DS consoles. It's the first and currently only one that supports both NTR and HzMod (the two available homebrew apps for streaming) and that can also receive streams from multiple 3DS consoles to the same PC using NTR. Unlike other clients Snickerstream has been rewritten completely from scratch, allowing it to offer a ton more features with an extremely small resource footprint. Plus, most of said features are shared with both streaming apps so you can use whichever one you want while retaining all your settings!

(NOTE: As of version 1.10 HzMod support is still experimental and partially incomplete and only its latest version is supported. However game compatibility is almost flawless, only very few titles cannot be streamed using Snickerstream but can be using HorizonScreen. All of this will be gradually fixed with each newer version!)

Snickerstream's three main focuses are performance, customizability and feature-richness. If all you want to do is to set up a simple 3DS streaming environment then your usual NTR & HzMod settings are all there, or if you don't want to touch them at all you can even choose one of the built-in presets. However, if you're someone who wants to tweak every single variable and setting to get everything up and running just the way you want it to be, you'll definitely feel just at home in the advanced menu... or in the settings INI, if that's more your thing.

Don't believe me? Here are some examples of features you can expect:
- Real time screen scaling
- Sevaral interpolation modes (improves the image quality especially if the window has been scaled)
- Portable: no DLL files needed (keep in mind that kit-kat still uses DLLs, they just get extracted to a temporary directory)
- Native x64 version for better performance on 64-bit computers
- MANY screen layouts, such borderless fullscreen and separate windows for both screens
- Pop-up secondary screen for fullscreen layouts (press SPACEBAR)
- More options that will make Snickerstream work better on crappy computers or networks
- Built-in screenshot function (press S while streaming to create a screenshot)
- Built in NFC patching
- 7 different built-in remoteplay presets are available, with support for creating your own customized ones
- Automatic remoteplay init, you only need to click connect and Snickerstream will care about everything else
- Auto-disconnects if the 3DS has stopped streaming (was shutdown/rebooted/etc, can be customized or disabled)
- Built-in frame limiter (disabled by default) if you wish to have a smoother stream
- It will try allow itself through Windows Firewall if ran as admin
- Toggable automatic screen centering for all layouts
- Customizable hotkeys
- Support for multiple NTR streaming to the same PC via NTR Patching

And that's not even counting HzMod support, which offers several features that NTR does not have!
- Supports both New and Old 3DS models
- It can stream multiple consoles to the same PC out of the box, without the need to change the ports or patching the executable
- You can change the stream's quality in real time (unlike NTR, which needs you to reboot your console in order to do that)
- It doesn't crash when soft-resetting or when you exit out of a game (shiny hunters, rejoice!)
- It works in a much cleaner and *stable* manner
- Better game compatibility (games that must be streamed using TARGA are currently not supported but this is caused by incomplete support in Snickerstream, not HzMod itself)
- Last but not least, it's still in development!
- The main downside is that HzMod is a bit slower when compared to NTR, but don't let that scare you off! It's usually not too big of a difference (especially if you take into account that many games run at 30FPS on the 3DS anyways) so all things considered you should definitely give HzMod a chance, especially if NTR crashes a lot or just doesn't work for you.

HzMod was made by @Sono who also helped me to add support for it in Snickerstream (thanks a lot again!) so if you enjoy it, that's who you should thank! =P

## Quick tutorial, Troubleshooting & FAQ

You can find tutorials, troubleshooting instructions & FAQ on Snickerstream's GitHub wiki!

## Keyboard shortcuts

ESC: Close Snickerstream. You can also close the program by right-clicking on the tray icon and selecting "Exit".

UP/DOWN ARROWS: Increase/Decrease scaling

LEFT/RIGHT ARROWS: Change interpolation settings

S: Take a screenshot

ENTER: Go back to the connection window

SPACEBAR: Pop up the other screen (can only be done in fullscreen modes)

S/D: Increase/Decrease streaming quality (HzMod only)

## How to compile
You need AutoIt v3.3.14.4 or later to compile Snickerstream.

After you've downloaded and installed AutoIt, clone this repo to your hard drive and use Aut2Exe to compile Snickerstream.au3 to an EXE file or open it in SciTE to run the script without compiling.

## Credits
Written by RattletraPM in AutoIt v3. Tested by Roman Sgarz and Silly Chip.
Snickerstream uses the Direct2D and WIC UDFs written by trancexx and Eukalyptus.
HzMod made by Sono, who also helped with adding HzMod support to Snickerstream.
Donations aren't a necessity but they're highly appreciated! :D
(Donations can be sent via
* PayPal - lucapm@live.it
* Bitcoin - 1MwsNoWiu2rHJbTNKWWhc25YpkZvmsFixN
* Monero - 439udJyDcr8hXrzjswx9pVEcefbph6osNU7mLAMpoabYZn77Bh9GtYBTNnVcjzvEHvdp9eTv7N8dmHUr6tyS5LXVLjaTEPp
