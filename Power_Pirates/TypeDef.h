//
//  TypeDef.h
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#ifndef TypeDef_h
#define TypeDef_h

//Storage Attribute Array-index
/*********************************************************************/
 #define NAME (1)
 #define AMOUNT (2)
 #define PRICE (3)
 /********************************************************************/

//Storage Data Array-index
/*********************************************************************/
#define FOOD (0)
#define DRINKS (1)
#define RUM (2)
#define FRUITS (3)
#define MONEY (4)
/********************************************************************/

//Pirate Attribute Array-index
/*********************************************************************/
#define P_NAME (1)
#define P_LIFE (2)
#define P_LVL (3)
#define P_ALCLVL (4)
#define P_BED (5)
/********************************************************************/

//Pirate Attribute DBNames
/*********************************************************************/
#define P_NAMEDB @"name"
#define P_LIFEDB @"leben"
#define P_LVLDB @"level"
#define P_ALCLVLDB @"pegel"
#define P_BEDDB @"geschaffteBeduerfnisse"
/********************************************************************/


//Storage/Pirate Standard Amount Values
/*********************************************************************/
#define LIFES_AMOUNT (5)
#define LEVEL_AMOUNT (1)
#define ALCLVL_AMOUNT (0)
#define FFDESIRE_AMOUNT (0)

#define FOOD_AMOUNT (1)
#define DRINKS_AMOUNT (1)
#define RUM_AMOUNT (0)
#define FRUITS_AMOUNT (0)
#define MONEY_AMOUNT (50)

#define MAX_SUPPLIES (5)
/*********************************************************************/

//Storage Standard Price Values
/*********************************************************************/
#define FOOD_PRICE (5)
#define DRINKS_PRICE (5)
#define RUM_PRICE (15)
#define FRUITS_PRICE (15)
#define MONEY_PRICE (1)
/*********************************************************************/

//Levelup-Limits
/*********************************************************************/
#define LVL2 (3)
#define LVL3 (6)
#define LVL4 (10)
#define LVL5 (15)
/*********************************************************************/

//Drunk-Limit (for alclvlv)
/*********************************************************************/
#define DRUNK (3)
/*********************************************************************/

//Desires
/*********************************************************************/
#define N_DESIRES (5)
#define MIN_TIME_BETWEEN_DESIRES (30)
#define MAX_TIME_BETWEEN_DESIRES (90)
#define MIN_TIME_TO_FAIL (20)
#define MAX_TIME_TO_FAIL (40)
/*********************************************************************/

//...
/*********************************************************************/
#define DATE_FORMAT @"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
/********************************************************************/


#endif /* TypeDef_h */
