#ifndef __CMD_KSP_DLG_HELPER_H__
#define __CMD_KSP_DLG_HELPER_H__

#include <Windows.h>
#include "KSP.h"
#include "Thread.h"
#include "CMDSignature.h"
#include "dialogs.h"

using namespace eIDMW;

SECURITY_STATUS
CmdKspOpenDialogSign(
__in    const wchar_t *userId,
__in    unsigned long userIdLen,
__out   wchar_t *pin,
__in    unsigned long pinLen,
__in    const wchar_t *userName,
__in    unsigned long userNameLen,
__in    HWND parentWindow);

SECURITY_STATUS
CmdKspOpenDialogOtp(
__out   wchar_t *otp,
__in    unsigned long otpLen,
__in    LPWSTR pszDocname,
__in    HWND parentWindow);

SECURITY_STATUS
CmdKspOpenDialogProgress(
__in    bool isValidateOtp,
__in    HWND parentWindow);

void
CmdKspOpenDialogError(
__in    const wchar_t *message,
__in    DlgCmdMsgType msgType,
__in    HWND parentWindow);

class CmdSignThread : public CThread
{
public:
    CmdSignThread(CMDProxyInfo *cmd_proxyinfo, CMDSignature *cmdSignature, std::string mobileNumber, std::string pin, CByteArray hash, char* docname);
    CmdSignThread(CMDSignature *cmdSignature, std::string otp);

    void Run();
    void Stop(unsigned long ulSleepFrequency = 100);

    int GetSignResult();

private:
    CMDProxyInfo *m_cmd_proxyinfo;
    CMDSignature *m_cmdSignature;
    std::string m_mobileNumber;
    std::string m_pin;
    std::string m_otp;
    CByteArray m_hash;
    char* m_docname;
    bool m_isValidateOtp;

    int m_signResult;
};
#endif