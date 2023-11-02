static const char *colorname[] = {
	[0] = "#123e7c",
	[1] = "#ff0000",
	[2] = "#d300c4",
	[3] = "#f57800",
	[4] = "#123e7c",
	[5] = "#711c91",
	[6] = "#0abdc6",
	[7] = "#d7d7d5",
	[8] = "#1c61c2",
	[9] = "#ff0000",
	[10] = "#d300c4",
	[11] = "#f57800",
	[12] = "#00ff00",
	[13] = "#711c91",
	[14] = "#0abdc6",
	[15] = "#d7d7d5",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	[256] = "#0abdc6", // foreground
	[257] = "#000b1e", // background
	[258] = "#ffffff", // cursor
};
unsigned int defaultfg = 256;
unsigned int defaultbg = 257;
unsigned int defaultcs = 258;
static unsigned int defaultrcs = 258;
