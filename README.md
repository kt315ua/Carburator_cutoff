# Carburator cutoff
Carburator cutoff

## Disclaimer
* Project as-is
* Real tests shows bad result: The carburetor pours the spark plugs by gasoline because ignition is missed.
* Firmwares founded on internet public resorces and require improves.

## Firmwares
* Binary firmwares: `./firmware_bin_hex/*.HEX`
* Source code: `./src`

## Doc
* PICBASIC PRO™ Compiler REFERENCE MANUAL: http://ww1.microchip.com/downloads/en/devicedoc/pbp_reference_manual.pdf

## Setup

    Щоб встановити поріг спрацьовування відсічки, натискаємо і утримуємо кнопку 2,
    потім виводимо двигун на бажані обороти і натискаємо кнопку 1, потім відпускаємо обидві кнопки.
    У момент натискання кнопки відбудеться запис поточних обертів.
    Після цього відсікання спрацьовуватиме на даних оборотах.

#### Notice

    Схема працюватиме і на 675 і на 629 піках,
    треба лише за компіляції вказати тип використовуваного контролера і ще у прошивці під 675 вимкнути АЦП (ANSEL = 0 ).

