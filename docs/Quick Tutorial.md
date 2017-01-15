#Quick Tutorial

This quick tutorial on how to use Snickerstream 0.6b PoC gives for granted that
you have installed NTR CFW on your New 3DS and you know how to get it up and running.

1) Open NTR CFW. I strongly suggest you to use BootNTR and NTR CFW v3.4 especially
if you're on firmware 11.2, but anything that works for you is going to be fine too.

2) Make sure that you're connected to your Wi-Fi network and find your 3DS's local IP
address. There are a few ways to do this, for example:

- Open FTPD and look at the top screen (you don't need the port, aka the number after
the ":")
- Use FBI (go to Remote Install -> Recieve URLs over the network)
- Set a static IP address

3) Insert your IP address and click on "Start remoteplay". 
IMPORTANT: DO NOT SET THE SCREEN PRIORITY TO BOTTOM SCREEN, you will get very low
FPS! (Read "Known issues" for an explaination)

4) Click on connect!

## Keyboard shortcuts

ESC: Close Snickerstream. You can also close the program by right-clicking on the
tray icon and selecting "Exit".

UP/DOWN ARROWS: Increase/Decrease scaling

LEFT/RIGHT ARROWS: Change interpolation settings

## NFC Patch

There is still no NFC patch function implemented in Snickerstream (there will be in
the future) but in the meantime you can use NTR Debugger to apply an universal NFC
patch to any game.

1) Start your game.

2) Click the home button

3) Start remoteplay via Snickerstream

4) Open NTRDebugger and connect to your 3DS by writing:

connect('ip', 8000)
ex. connect('192.168.1.50', 8000)

5) Once connected, send the following command:

write(0x0105AE4, (0x70, 0x47), pid=0x1a)

## Bonus: Improve performance!

The default settings are NTR Debugger's own defaults, so they might not work well
for you. In case they don't, try those:

For "meh" connections:
Image quality: 75
QoS Value: 15

For really crappy connections:
Priority factor: 7
Image quality: 50
QoS value: 15
