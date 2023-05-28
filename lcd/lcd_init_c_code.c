#include <stdint.h>
extern void lcd1502();
void lcd_init(void);
void lcd_delay(int time_ms);

/*
 * Delay function for the LCD display.
 * Source:  https://microcontrollerslab.com/spi-tm4c123-communication-between-tiva-launchpad-arduino/
 */
void lcd_delay(int time_ms)
{
    int i, j;
    for (i = 0; i < time_ms; i++)
        for (j = 0; j < 3180; j++)
        {}  /* Executes NOP for 1ms. */

}

void lcd_init(void)
{
    /************************************************/
    /* When translating the following to assembly   */
    /* it is advised to use LDR and STR as opposed  */
    /* to LDRB and STRB.                            */
    /************************************************/

    /*************************************************/
    /* The OR operation sets the bits that are OR'ed */
    /* with a 1.  To translate the following lines   */
    /* to assembly, load the data, OR the data with  */
    /* the mask and store the result back.           */
    /* For AND NOT use BIC instruction to clear the  */
    /* bits that have a 1.                           */
    /*************************************************/

    /* Provide clock to SPI2  */
    (*((volatile uint32_t *)(0x400FE61C))) |= 4;
    /* Enable clock to Port B and Port C  */
    (*((volatile uint32_t *)(0x400FE608))) |= 6;
    /* Set PB4 and PB7 to digital. */
    (*((volatile uint32_t *)(0x4000551c))) |= 0x90;
    /* Set PB4 and PB7 to alternate function. */
    (*((volatile uint32_t *)(0x40005420))) |= 0x90;
    /* Set PB4 and PB7 to use SPI2 as alternate function. */
    (*((volatile uint32_t *)(0x4000552c))) &= ~(0xf00f0000);
    (*((volatile uint32_t *)(0x4000552c))) |= (0x20020000);
    /* Set PC6 as output. */
    (*((volatile uint32_t *)(0x40006400))) |= 0x40;
    /* Set PC6 as digital. */
    (*((volatile uint32_t *)(0x4000651c))) |= 0x40;
    /* Set PC6 high. */
    (*((volatile uint32_t *)(0x40006100))) |= 0x40; // Use 0x100 to only modify the 6th bit.
                                                    // This is because the Tiva uses bits 9:2
                                                    // of the address to determine which bits
                                                    // should be modified.
                                                    // 3fc can also be used to modify all bits.
    /* Disable SPI2 and configure as master. */
    (*((volatile uint32_t *)(0x4000A004))) &= ~(0x4);
    /* Use system clock for SPI2. */
    (*((volatile uint32_t *)(0x4000Afc8))) &= ~(0x1);
    /* Set the prescaler value. */
    (*((volatile uint32_t *)(0x4000A010))) = 4;
    /* Set SPI2 to use 8-bit data. */
    (*((volatile uint32_t *)(0x4000A000))) &= ~(0x0f);
    (*((volatile uint32_t *)(0x4000A000))) |= 7;
    /* Enable SPI2. */
    (*((volatile uint32_t *)(0x4000A004))) |= 2;

    /* Give LCD time to power up. */
    lcd_delay(30);

}




/**
 * main.c
 */
int main(void)
{
    lcd_init();
    lcd1502();
    return 0;
}
