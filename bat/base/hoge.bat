@echo off

echo start hoge.bat

setlocal

rem __________�p�����[�^
echo commandName: %0
echo param_1: %1
echo param_2: %2


rem __________SET
set name=john
echo %name%


rem __________goto
goto label_b1

:label_a1
echo label_a1

:label_b1
echo label_b1


rem __________call
rem �Ăяo����ɖ߂�܂�
call sub_fufu.bat
call sub_koko.bat


rem __________sub routine ���g��Ȃ���
@REM call :funcA "abc" "def"
@REM exit /B 0

@REM :funcA
@REM     echo funcA(%1, %2)
@REM     exit /B 0


rem __________start ���g��Ȃ�����
@rem �ʃv���Z�X�Ŏ��s�����Ă܂�
@REM start sub_fufu.bat

@REM rem �����E�B���h�E���ŃR�}���h�����s
@REM rem start /B sub_fufu.bat

@REM rem �ʂ̃E�B���h�E���J���R�}���h�����s�A�I����҂�
@REM rem start /WAIT sub_fufu.bat

@REM rem �E�B���h�E���ŏ��������s
@REM start /MIN sub_fufu.bat


rem �ʃv���Z�X�Ŏ��s�A�I�����܂����Ɏ��̏�����
rem start sub_otherprocess_nana.bat

rem �ʃv���Z�X�Ŏ��s�A�I����҂�
start /wait sub_otherprocess_nana.bat


rem __________���_
rem �R�}���h�̌��ʑ���̓o�b�`�ł͍s�킸Powershell�őΉ����邽�߁A���܂�g�����Ƃ�͂Ȃ��Ǝv���܂��B
rem �K�v�Ȃ璲�����Ή����܂��B


echo end hoge.bat
endlocal

