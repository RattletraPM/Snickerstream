# Snickerstream-ES

![Snickerstream-ES](https://raw.githubusercontent.com/JustSofter/Snickerstream-ES/master/res/snickerstream-esp.png)

Snickerstream-ES es un cliente de streaming para consolas Nintendo 3DS. Es el primero y actualmente el único que admite tanto NTR como HzMod (las dos aplicaciones disponibles para transmisión) y que también puede recibir transmisiones desde múltiples consolas 3DS a la misma PC usando NTR CFW. A diferencia de otros clientes, Snickerstream se ha reescrito completamente desde cero, lo que le permite ofrecer muchas más funciones con una huella de recursos extremadamente pequeña. Además, la mayoría de dichas funciones se comparten con ambas aplicaciones de transmisión, por lo que puede usar la que desee mientras conserva todas sus configuraciones.

(NOTA: a partir de la versión 1.10, la compatibilidad con HzMod aún es experimental y está parcialmente incompleta, y solo se admite su última versión. Sin embargo, la compatibilidad con los juegos es casi perfecta, solo unos pocos títulos no se pueden transmitir con Snickerstream-ES pero sí con HorizonScreen. Todo esto será arreglado gradualmente con cada nueva versión!)

Los tres enfoques principales de Snickerstream son el rendimiento, la personalización y la riqueza de funciones. Si todo lo que quiere hacer es configurar un entorno de transmisión 3DS simple, entonces sus configuraciones habituales de NTR y HzMod están todas ahí, o si no quiere tocarlas en absoluto, incluso puede elegir uno de los ajustes preestablecidos incorporados. Sin embargo, si usted es alguien que quiere modificar cada variable y configuración para que todo funcione de la manera que desea, definitivamente se sentirá como en casa en el menú avanzado... o en la configuración. INI, si eso es más lo tuyo.

¿No me crees? Estos son algunos ejemplos de características que puede esperar:
- Escalado de pantalla en tiempo real
- Varios modos de interpolación (mejora la calidad de la imagen especialmente si se ha escalado la ventana)
- Portable: no se necesitan archivos DLL (tenga en cuenta que kit-kat todavía usa archivos DLL, solo se extraen a un directorio temporal)
- Versión nativa x64 para un mejor rendimiento en equipos de 64 bits
- MUCHOS diseños de pantalla, como pantalla completa sin bordes y ventanas separadas para ambas pantallas
- Pop-up para posiciones de pantalla completa (presione la BARRA ESPACIADORA)
- Más opciones que harán que Snickerstream-ES funcione mejor en computadoras o redes deficientes
- Función de captura de pantalla incorporada (presione S mientras transmite para crear una captura de pantalla)
- Parcheado NFC incorporado
- Hay 7 disponibles preajustes de stream diferentes, con soporte para crear los tuyos propios personalizados
- Inicio automático de reproducción remota, solo necesita hacer clic en conectar y Snickerstream-ES se encargará de todo lo demás
- Se desconecta automáticamente si el 3DS ha dejado de transmitir (se apagó/reinició/etc., se puede personalizar o deshabilitar)
- Limitador de frames incorporado (deshabilitado de forma predeterminada) si desea tener una transmisión más fluida
- Intentará permitirse a sí mismo a través del Firewall de Windows si se ejecuta como administrador
- Centrado de pantalla automático conmutable para todos los diseños
- Teclas de acceso directo personalizables
- Soporte para múltiples transmisiones NTR a la misma PC a través de NTR Patching

¡Y eso sin contar la compatibilidad con HzMod, que ofrece varias características que NTR no tiene!
- Admite modelos 3DS nuevos y antiguos
- Puede transmitir varias consolas a la misma PC desde el primer momento, sin necesidad de cambiar los puertos o parchear el ejecutable
- Puede cambiar la calidad de la transmisión en tiempo real (a diferencia de NTR, que necesita que reinicie su consola para hacerlo)
- No se bloquea cuando se reinicia suavemente o cuando sales de un juego (cazadores brillantes, ¡regocíjate!)
- Funciona de una manera mucho más limpia y *estable*
- Mejor compatibilidad de juegos (los juegos que deben transmitirse mediante TARGA actualmente no son compatibles, pero esto se debe a una compatibilidad incompleta en Snickerstream, no en HzMod en sí)
- Por último, pero no menos importante, ¡todavía está en desarrollo!
- El principal inconveniente es que HzMod es un poco más lento en comparación con NTR, ¡pero no dejes que eso te asuste! Por lo general, no es una diferencia demasiado grande (especialmente si tiene en cuenta que muchos juegos se ejecutan a 30FPS en 3DS de todos modos), por lo que, considerando todas las cosas, definitivamente debería darle una oportunidad a HzMod, especialmente si NTR falla mucho o simplemente no funciona. para ti.

HzMod fue creado por @Sono, quien también me ayudó a agregar soporte para él en Snickerstream (¡muchas gracias de nuevo!), así que si lo disfrutas, ¡es a quien debes agradecer! =P

## Atajos de teclado

ESC: Cerrar Snickerstream-ES. También puede cerrar el programa haciendo clic derecho en el icono de la bandeja y seleccionando "Salir".

FLECHAS ARRIBA/ABAJO: Aumentar/Disminuir la escala

FLECHAS IZQUIERDA/DERECHA: cambiar la configuración de interpolación

S: toma una captura de pantalla

ENTER: Volver a la ventana de conexión

BARRA ESPACIADORA: muestra la otra pantalla (solo se puede hacer en los modos de pantalla completa)
S/D: aumentar/disminuir la calidad de transmisión (solo HzMod)

## Como compilar
Necesita AutoIt v3.3.14.4 o posterior para compilar Snickerstream.-ES

Después de descargar e instalar AutoIt, clone este repositorio en su disco duro y use Aut2Exe para compilar Snickerstream.au3 en un archivo EXE o ábralo en SciTE para ejecutar el script sin compilar.

## Créditos
Escrito por RattletraPM en AutoIt v3. Probado por Roman Sgarz y Silly Chip.
Snickerstream utiliza Direct2D y WIC UDF escritos por trancexx y Eukalyptus.
HzMod creado por Sono, quien también ayudó a agregar compatibilidad con HzMod a Snickerstream.