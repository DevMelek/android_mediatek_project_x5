# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.
#
# MediaTek Inc. (C) 2010. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.

ifneq ($(MTK_EMULATOR_SUPPORT), yes)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := jni_pq.cpp

LOCAL_C_INCLUDES :=  \
    $(JNI_H_INCLUDE) \
    $(MTK_PATH_SOURCE)/hardware/pq/v2.0/include \
    $(MTK_PATH_SOURCE)/../libs/libpq_prot/mt6580/include

LOCAL_SHARED_LIBRARIES := \
    libutils \
    libcutils \
    libpq_prot \
    liblog

ifeq (,$(filter $(strip $(MTK_PQ_SUPPORT)), no PQ_OFF))
    LOCAL_CFLAGS += -DMTK_PQ_SERVICE

    LOCAL_SHARED_LIBRARIES += \
        libhidlbase \
        vendor.mediatek.hardware.pq@2.0
endif

ifeq ($(strip $(MTK_AAL_SUPPORT)),yes)
    LOCAL_CFLAGS += -DMTK_AAL_SUPPORT

    LOCAL_C_INCLUDES += \
        $(MTK_PATH_SOURCE)/hardware/aal/include/AAL20

    LOCAL_SHARED_LIBRARIES += \
        libaalservice \
        libbinder
endif

ifeq ($(strip $(MTK_OD_SUPPORT)),yes)
    LOCAL_CFLAGS += -DMTK_OD_SUPPORT
endif

ifeq ($(strip $(MTK_MIRAVISION_IMAGE_DC_SUPPORT)),yes)
    LOCAL_CFLAGS += -DMTK_MIRAVISION_IMAGE_DC_SUPPORT
endif

ifeq ($(strip $(MTK_GLOBAL_PQ_SUPPORT)),yes)
    LOCAL_CFLAGS += -DMTK_GLOBAL_PQ_SUPPORT
endif

ifeq ($(MTK_BLULIGHT_DEFENDER_SUPPORT),yes)
    LOCAL_CFLAGS += -DMTK_BLULIGHT_DEFENDER_SUPPORT
endif

ifeq ($(MTK_CHAMELEON_DISPLAY_SUPPORT),yes)
    LOCAL_CFLAGS += -DMTK_CHAMELEON_DISPLAY_SUPPORT
endif

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libjni_pq
LOCAL_MULTILIB := both


include $(MTK_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
