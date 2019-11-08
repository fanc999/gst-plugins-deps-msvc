# Convert the source listing to object (.obj) listing in
# another NMake Makefile module, include it, and clean it up.
# This is a "fact-of-life" regarding NMake Makefiles...
# This file does not need to be changed unless one is maintaining the NMake Makefiles

# For those wanting to add things here:
# To add a list, do the following:
# # $(description_of_list)
# if [call create-lists.bat header $(makefile_snippet_file) $(variable_name)]
# endif
#
# if [call create-lists.bat file $(makefile_snippet_file) $(file_name)]
# endif
#
# if [call create-lists.bat footer $(makefile_snippet_file)]
# endif
# ... (repeat the if [call ...] lines in the above order if needed)
# !include $(makefile_snippet_file)
#
# (add the following after checking the entries in $(makefile_snippet_file) is correct)
# (the batch script appends to $(makefile_snippet_file), you will need to clear the file unless the following line is added)
#!if [del /f /q $(makefile_snippet_file)]
#!endif

# In order to obtain the .obj filename that is needed for NMake Makefiles to build DLLs/static LIBs or EXEs, do the following
# instead when doing 'if [call create-lists.bat file $(makefile_snippet_file) $(file_name)]'
# (repeat if there are multiple $(srcext)'s in $(source_list), ignore any headers):
# !if [for %c in ($(source_list)) do @if "%~xc" == ".$(srcext)" @call create-lists.bat file $(makefile_snippet_file) $(intdir)\%~nc.obj]
#
# $(intdir)\%~nc.obj needs to correspond to the rules added in build-rules-msvc.mak
# %~xc gives the file extension of a given file, %c in this case, so if %c is a.cc, %~xc means .cc
# %~nc gives the file name of a given file without extension, %c in this case, so if %c is a.cc, %~nc means a

NULL=

# For libopus
OPUS_BASE_SRCS =	\
	..\celt\bands.c	\
	..\celt\celt.c	\
	..\celt\celt_decoder.c	\
	..\celt\celt_encoder.c	\
	..\celt\celt_lpc.c	\
	..\celt\cwrs.c	\
	..\celt\entcode.c	\
	..\celt\entdec.c	\
	..\celt\entenc.c	\
	..\celt\kiss_fft.c	\
	..\celt\laplace.c	\
	..\celt\mathops.c	\
	..\celt\mdct.c	\
	..\celt\modes.c	\
	..\celt\pitch.c	\
	..\celt\quant_bands.c	\
	..\celt\rate.c	\
	..\celt\vq.c	\
	..\celt\x86\celt_lpc_sse.c	\
	..\celt\x86\pitch_sse.c	\
	..\celt\x86\pitch_sse2.c	\
	..\celt\x86\pitch_sse4_1.c	\
	..\celt\x86\vq_sse2.c	\
	..\celt\x86\x86cpu.c	\
	..\celt\x86\x86_celt_map.c	\
	..\silk\A2NLSF.c	\
	..\silk\ana_filt_bank_1.c	\
	..\silk\biquad_alt.c	\
	..\silk\bwexpander.c	\
	..\silk\bwexpander_32.c	\
	..\silk\check_control_input.c	\
	..\silk\CNG.c	\
	..\silk\code_signs.c	\
	..\silk\control_audio_bandwidth.c	\
	..\silk\control_codec.c	\
	..\silk\control_SNR.c	\
	..\silk\debug.c	\
	..\silk\decoder_set_fs.c	\
	..\silk\decode_core.c	\
	..\silk\decode_frame.c	\
	..\silk\decode_indices.c	\
	..\silk\decode_parameters.c	\
	..\silk\decode_pitch.c	\
	..\silk\decode_pulses.c	\
	..\silk\dec_API.c	\
	..\silk\encode_indices.c	\
	..\silk\encode_pulses.c	\
	..\silk\enc_API.c	\
	..\silk\gain_quant.c	\
	..\silk\HP_variable_cutoff.c	\
	..\silk\init_decoder.c	\
	..\silk\init_encoder.c	\
	..\silk\inner_prod_aligned.c	\
	..\silk\interpolate.c	\
	..\silk\lin2log.c	\
	..\silk\log2lin.c	\
	..\silk\LPC_analysis_filter.c	\
	..\silk\LPC_fit.c	\
	..\silk\LPC_inv_pred_gain.c	\
	..\silk\LP_variable_cutoff.c	\
	..\silk\NLSF2A.c	\
	..\silk\NLSF_decode.c	\
	..\silk\NLSF_del_dec_quant.c	\
	..\silk\NLSF_encode.c	\
	..\silk\NLSF_stabilize.c	\
	..\silk\NLSF_unpack.c	\
	..\silk\NLSF_VQ.c	\
	..\silk\NLSF_VQ_weights_laroia.c	\
	..\silk\NSQ.c	\
	..\silk\NSQ_del_dec.c	\
	..\silk\pitch_est_tables.c	\
	..\silk\PLC.c	\
	..\silk\process_NLSFs.c	\
	..\silk\quant_LTP_gains.c	\
	..\silk\resampler.c	\
	..\silk\resampler_down2.c	\
	..\silk\resampler_down2_3.c	\
	..\silk\resampler_private_AR2.c	\
	..\silk\resampler_private_down_FIR.c	\
	..\silk\resampler_private_IIR_FIR.c	\
	..\silk\resampler_private_up2_HQ.c	\
	..\silk\resampler_rom.c	\
	..\silk\shell_coder.c	\
	..\silk\sigm_Q15.c	\
	..\silk\sort.c	\
	..\silk\stereo_decode_pred.c	\
	..\silk\stereo_encode_pred.c	\
	..\silk\stereo_find_predictor.c	\
	..\silk\stereo_LR_to_MS.c	\
	..\silk\stereo_MS_to_LR.c	\
	..\silk\stereo_quant_pred.c	\
	..\silk\sum_sqr_shift.c	\
	..\silk\tables_gain.c	\
	..\silk\tables_LTP.c	\
	..\silk\tables_NLSF_CB_NB_MB.c	\
	..\silk\tables_NLSF_CB_WB.c	\
	..\silk\tables_other.c	\
	..\silk\tables_pitch_lag.c	\
	..\silk\tables_pulses_per_block.c	\
	..\silk\table_LSF_cos.c	\
	..\silk\VAD.c	\
	..\silk\VQ_WMat_EC.c	\
	..\silk\x86\NSQ_del_dec_sse.c	\
	..\silk\x86\NSQ_sse.c	\
	..\silk\x86\VAD_sse.c	\
	..\silk\x86\VQ_WMat_EC_sse.c	\
	..\silk\x86\x86_silk_map.c	\
	..\src\analysis.c	\
	..\src\mlp.c	\
	..\src\mlp_data.c	\
	..\src\opus.c	\
	..\src\opus_compare.c	\
	..\src\opus_decoder.c	\
	..\src\opus_encoder.c	\
	..\src\opus_multistream.c	\
	..\src\opus_multistream_decoder.c	\
	..\src\opus_multistream_encoder.c	\
	..\src\repacketizer.c

!if "$(FIXED_POINT)" == "1"
SILK_ADDITIONAL_DIRS = ..\silk\fixed ..\silk\fixed\x86
!else
SILK_ADDITIONAL_DIRS = ..\silk\float
!endif

!if [call create-lists.bat header opus_objs.mak opus_dll_OBJS]
!endif

!if [for %c in ($(OPUS_BASE_SRCS)) do @if "%~xc" == ".c" @call create-lists.bat file opus_objs.mak ^$(CFG)\^$(PLAT)\libopus\%~nc.obj]
!endif

!if [for %d in ($(SILK_ADDITIONAL_DIRS)) do @(for %c in (%d\*.c) do @call create-lists.bat file opus_objs.mak ^$(CFG^)\^$(PLAT^)\libopus\%~nc.obj)]
!endif

!if [call create-lists.bat footer opus_objs.mak]
!endif

!include opus_objs.mak

!if [del /f /q opus_objs.mak]
!endif
