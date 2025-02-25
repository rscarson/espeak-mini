#include <espeak_ng.h>

int main(int argc, char* argv[]) {
    espeak_Initialize(
        AUDIO_OUTPUT_RETRIEVAL, 0, NULL, espeakINITIALIZE_DONT_EXIT | espeakINITIALIZE_PHONEME_IPA
    );
}