#define STATKEY_STR "strength"
#define STATKEY_PER "perception"
#define STATKEY_INT "intelligence"
#define STATKEY_CON "constitution"
#define STATKEY_WIL "willpower"
#define STATKEY_SPD "speed"
#define STATKEY_LCK "fortune"

//This was previously in vampirelord.dm and mob/living/stats.dm, the person defined it twice because vampirelord came in below that stats file, so now both of them can get it here.
#define MOBSTATS list(STATKEY_STR, STATKEY_PER, STATKEY_INT, STATKEY_CON, STATKEY_WIL, STATKEY_SPD, STATKEY_LCK)
