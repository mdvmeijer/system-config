/* Copyright 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* Keyboard configuration constants for Chrome EC */

#ifndef __CROS_EC_KEYBOARD_CONFIG_H
#define __CROS_EC_KEYBOARD_CONFIG_H

#include "common.h"

#ifdef CONFIG_KEYBOARD_CUSTOMIZATION
/* include the board layer keyboard header file */
#include "keyboard_customization.h"
#else /* CONFIG_KEYBOARD_CUSTOMIZATION */
#ifdef CONFIG_KEYBOARD_LANGUAGE_ID
/* Keyboard matrix support for language ID pins */
#define KEYBOARD_IDS 2
#endif

/* Keyboard matrix is 13 (or 15 with keypad) output columns x 8 input rows */
#define KEYBOARD_COLS_WITH_KEYPAD	15
#define KEYBOARD_COLS_NO_KEYPAD		13

/*
 * KEYBOARD_COLS_MAX has the build time column size. It's used to allocate
 * exact spaces for arrays. Actual keyboard scanning is done using
 * keyboard_cols, which holds a runtime column size.
 */
#ifdef CONFIG_KEYBOARD_KEYPAD
#define KEYBOARD_COLS_MAX KEYBOARD_COLS_WITH_KEYPAD
#else
#define KEYBOARD_COLS_MAX KEYBOARD_COLS_NO_KEYPAD
#endif
#define KEYBOARD_ROWS 8

/*
 * WARNING: Do not directly modify it. You should call keyboard_raw_set_cols,
 * instead. It checks whether you're eligible or not.
 */
extern uint8_t keyboard_cols;

#define KEYBOARD_ROW_TO_MASK(r) (1 << (r))

/* Columns and masks for keys we particularly care about */
#define KEYBOARD_COL_DOWN	11
#define KEYBOARD_ROW_DOWN	6
#define KEYBOARD_MASK_DOWN	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_DOWN)
#define KEYBOARD_COL_ESC	1
#define KEYBOARD_ROW_ESC	1
#define KEYBOARD_MASK_ESC	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_ESC)
#define KEYBOARD_COL_KEY_H	6
#define KEYBOARD_ROW_KEY_H	1
#define KEYBOARD_MASK_KEY_H	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_KEY_H)
#define KEYBOARD_COL_KEY_R	3
#define KEYBOARD_ROW_KEY_R	7
#define KEYBOARD_MASK_KEY_R	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_KEY_R)
#define KEYBOARD_COL_LEFT_ALT	10
#define KEYBOARD_ROW_LEFT_ALT	6
#define KEYBOARD_MASK_LEFT_ALT	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_LEFT_ALT)
#define KEYBOARD_COL_REFRESH	2
#ifdef CONFIG_KEYBOARD_REFRESH_ROW3
#define KEYBOARD_ROW_REFRESH	3
#else
#define KEYBOARD_ROW_REFRESH	2
#endif
#define KEYBOARD_MASK_REFRESH	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_REFRESH)
#define KEYBOARD_COL_RIGHT_ALT	10
#define KEYBOARD_ROW_RIGHT_ALT	0
#define KEYBOARD_MASK_RIGHT_ALT	KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_RIGHT_ALT)
#define KEYBOARD_DEFAULT_COL_VOL_UP	4
#define KEYBOARD_DEFAULT_ROW_VOL_UP	0
#define KEYBOARD_COL_LEFT_CTRL  0
#define KEYBOARD_ROW_LEFT_CTRL  2
#define KEYBOARD_MASK_LEFT_CTRL KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_LEFT_CTRL)
#define KEYBOARD_COL_RIGHT_CTRL 0
#define KEYBOARD_ROW_RIGHT_CTRL 4
#define KEYBOARD_MASK_RIGHT_CTRL KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_RIGHT_CTRL)
#define KEYBOARD_COL_SEARCH     1
#define KEYBOARD_ROW_SEARCH     0
#define KEYBOARD_MASK_SEARCH    KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_SEARCH)
#define KEYBOARD_COL_KEY_0      8
#define KEYBOARD_ROW_KEY_0      6
#define KEYBOARD_MASK_KEY_0     KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_KEY_0)
#define KEYBOARD_COL_KEY_1      1
#define KEYBOARD_ROW_KEY_1      6
#define KEYBOARD_MASK_KEY_1     KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_KEY_1)
#define KEYBOARD_COL_KEY_2      4
#define KEYBOARD_ROW_KEY_2      6
#define KEYBOARD_MASK_KEY_2     KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_KEY_2)
#define KEYBOARD_COL_LEFT_SHIFT 7
#define KEYBOARD_ROW_LEFT_SHIFT 5
#define KEYBOARD_MASK_LEFT_SHIFT KEYBOARD_ROW_TO_MASK(KEYBOARD_ROW_LEFT_SHIFT)
#ifdef CONFIG_KEYBOARD_PWRBTN_ASSERTS_KSI2
#define KEYBOARD_MASK_PWRBTN	KEYBOARD_ROW_TO_MASK(2)
#elif defined(CONFIG_KEYBOARD_PWRBTN_ASSERTS_KSI3)
#define KEYBOARD_MASK_PWRBTN	KEYBOARD_ROW_TO_MASK(3)
#endif

#endif /* CONFIG_KEYBOARD_CUSTOMIZATION */
#endif  /* __CROS_EC_KEYBOARD_CONFIG_H */
