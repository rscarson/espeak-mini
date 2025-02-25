CC = clang
LINK = -lkernel32 \
	   -luser32 \
	   -lgdi32 \
	   -lwinspool \
	   -lcomdlg32 \
	   -ladvapi32 \
	   -lshell32 \
	   -lole32 \
	   -loleaut32 \
	   -luuid \
	   -lodbc32 \
	   -lodbccp32
_LINK = -lAdvapi32 -lglew32
WARNINGS = -Wno-attributes -Wno-deprecated-declarations -Wno-pointer-sign -Wno-int-conversion
CFLAGS = -Iinclude -fvisibility=hidden -fno-exceptions -fwrapv $(WARNINGS)

# Define target dir (create subdirectories for obj and lib)
OBJ_DIR = obj
LIB_DIR = lib

_UCD = ucd/case.o ucd/categories.o ucd/ctype.o ucd/proplist.o ucd/scripts.o ucd/tostring.o
UCD = $(patsubst %,$(OBJ_DIR)/%,$(_UCD))

_OBJ = common.o mnemonics.o error.o ieee80.o compiledata.o compiledict.o dictionary.o encoding.o intonation.o langopts.o numbers.o phoneme.o phonemelist.o readclause.o setlengths.o soundicon.o spect.o ssml.o synthdata.o synthesize.o tr_languages.o translate.o translateword.o voices.o wavegen.o speech.o espeak_api.o
OBJ = $(patsubst %,$(OBJ_DIR)/%,$(_OBJ))

$(OBJ_DIR)/%.o: src/%.c
	$(CC) -c -o $@ $< $(CFLAGS)

clean: 
	del $(OBJ_DIR)\*.o $(OBJ_DIR)\ucd\*.o $(LIB_DIR)\speak.*

all: speak.lib test

speak.lib: $(OBJ) $(UCD)
	ar rcs -o $(LIB_DIR)/$@ $^

test.exe: test.c
	$(CC) -o test test.c -Iinclude -Llib -lspeak $(LINK)