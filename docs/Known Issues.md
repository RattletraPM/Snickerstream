- If priority mode is set to bottom screen you will get very low FPS. That's because
Snickerstream will change the priority mode in NTR but it will still expect the top
screen to have priority in the client.


- If the "About" message box is shown and the corresponding GUI button is pressed,
multiple message boxes will be opened when the current one is closed. This bug is
caused by message boxes and OnEvent mode and will probably be fixed when a proper
"About" window will be coded.


- Horizontal and single screen layouts aren't coded yet, so even if you choose
them, you'll still get the default vertical layout.


- The client will ignore any key presses if it's not rendering any frames. This
could prove annoying when closing Snickerstream while there's a connection error.
In that case, close Snickerstream from the tray icon.


-Not really an issue, being more like lazy coding. Still. You can scale the window
to a ridiculosly big or small size (window size checks aren't implemented yet). 
Also, the scaling factor is exponential and not linear (1x, 2x, 4x, 8x, 16x, etc.
instead of 1x, 2x, 3x, 4x, etc.)
