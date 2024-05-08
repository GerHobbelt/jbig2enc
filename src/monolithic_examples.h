
#pragma once

#if defined(BUILD_MONOLITHIC)

#ifdef __cplusplus
extern "C" {
#endif

extern int jbig2dec_main(int argc, const char** argv);
extern int jbig2dec_arith_test_main(int argc, const char** argv);
extern int jbig2dec_huffman_test_main(int argc, const char** argv);
extern int jbig2dec_pbm2png_main(int argc, const char** argv);

#ifdef __cplusplus
}
#endif

#endif
