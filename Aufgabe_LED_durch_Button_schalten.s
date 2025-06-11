.syntax unified // es wird die neueste Syntax ( Regelsystem für die Darstellung von Befehlen) verwendet
// -------------- Konstantendeklaration -----------------------------------------------------------
// Portdeklarationen - Jeder Port hat 12 Konfigurationsregister -> Offsetadressen
GPIOA = 0x40020000 // Basisadresse Port A (16 Bit)
GPIOB = 0x40020400 // Basisadresse Port B (16 Bit)
GPIOC = 0x40020800 // Basisadresse Port C (16 Bit)
GPIOD = 0x40020C00 // Basisadresse Port D (16 Bit)
GPIOE = 0x40021000 // Basisadresse Port E (16 Bit)
GPIOH = 0x40021C00 // Basisadresse Port H (16 Bit)
// Port-Offsetadressen - Adressen für je 4 Byte -> Konfigurationsregister
MODER = 0x00 // Modifikationsregister - 2 Bit/Portpin {input // output // alternate Funktion // analog mod}
OTYPER = 0x04 // Out-Put-Type-Register nur untere 16 Bit (1 Bit/Portpin) {push-pull // open-drain}
OSPEEDR = 0x08 // Out-Put-Speed-Register - 2 Bit/Portpin {low // medium // fast // high } speed
PUPDR = 0x0C // Pull-Up-Down-Register - 2 Bit/Portpin {no pull-up/down // pull-up // pull-down // reserved}
IDR = 0x10 // Input-Data-Register nur untere 16 Bit - read-only
ODR = 0x14 // Output-Data-Register nur untere 16 Bit - read and write
BSRR = 0x18 // Bit-Set/Reset-Register
LCKR = 0x1C // configuration Lock Register
AFRL = 0x20 // Alternate Funktion Register Low
AFRH = 0x24 // Alternate Funktion Register High
RCC = 0x40023800 // Reset and Clock-Control-Register
RCC_AHB1ENR = 0x30 // peripheral clock enable register -> Freigabe der Ports 

LED_PIN = 5 // Pinnummer der LED auf dem Board an Port A Pin 5
USER_BUTTON_PIN= 13 // Pinnummer des Blauen Buttons auf dem Board an Port C Pin 13

// -------------- Code Section -----------------------------------------------------------------
.section .text // Bereich für Instruktionen (.data = Bereich für initialisierte Daten, .bss = uninitialisierte)
.global main // main kann aus einem anderen File angesprungen werden (z.B. von startup_stm32f411xe.s)
// -------------- Hauptprogramm ----------------------------------------------------------------
main: 
initialisieren:
    // aktiviere GPIO A-C
    ldr r1,=RCC // R1 = Adresse von rcc (siehe equ-Anweisung)
    ldr r2,[r1,#RCC_AHB1ENR] // R2 = Inhalt der Adrese[rcc+offset AVB1ENR]
    orr r2,#0x7 // setze die unteren 3 Bit von R2 auf 1
    str r2,[r1,#RCC_AHB1ENR] // Speicherzelle[RCC+offset AVB1ENR] = R2 


    // GPIOC ---- Input ------------------------------
    // TODO Button-Pin als Input einrichten

    // GPIOA ------ LED an Port A auf dem Board als Output 
    // TODO: LED-Pin als Output einrichten

    // Status um LED Zustand zu speichern (hinterstes Bit von r0)
    // TODO: r0 initialisieren
	
loop:
    bl button_einlesen // Buttonstatus einlesen (per Unterprogramm)
    // nun gilt r2=0 wenn der Userbutton gedrückt ist und r2>1 wenn er nicht gedrückt ist
    
gedrueckt_abfragen:
    // TODO: implementieren


led_zustand_wechseln:
    // TODO: implementieren. Hinweis: Ein Bit invertieren kann man mit einer Maske und exor


button_loslassen_abwarten:    
    bl button_einlesen
    // TODO: implementieren.
    b loop




// -------------- Unterprogramme ----------------------------------------------------------------
button_einlesen:   // Egebnis soll dannach in r2 stehen
    // TODO: implementieren


warten:   
    ldr r1,=10000 // Startwert um zu warten durch Runterzählen
    warten_intern:
    sub r1, #1 // runterzählen
    cmp r1,#0 // prüfe ob schon auf 0 runtergezählt wurde
    bne warten_intern // springe zurück bis runtergezählt wurde
    bx lr