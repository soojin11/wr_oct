// ConsoleApplication1.cpp : 이 파일에는 'main' 함수가 포함됩니다. 거기서 프로그램 실행이 시작되고 종료됩니다.
//

#include <iostream>
#include "SerialPort.h"
#include <oaidl.h>
#include <string >
#define EXPORT extern "C" __declspec(dllexport)
#import "WGSCOM.tlb" no_namespace named_guids


#include <stdint.h>

extern "C" __declspec(dllexport) ICallClass* csharp = NULL;
extern "C" __declspec(dllexport) HRESULT g_hr = S_OK;
extern "C" __declspec(dllexport) double* g_dData = nullptr;
extern "C" __declspec(dllexport) double* g_dData2 = nullptr;
extern "C" __declspec(dllexport) byte* g_byData = nullptr;

extern "C" __declspec(dllexport) int OCR_Start()
{
	CoInitialize(NULL);
	g_hr = CoCreateInstance(CLSID_Wgstest, NULL, CLSCTX_INPROC_SERVER, IID_ICallClass, reinterpret_cast<void**>(&csharp));

    return SUCCEEDED(g_hr);
}

//MPM2000 함수
extern "C" __declspec(dllexport) void MPMStart(int nPort)
{
    csharp->MPMStart(nPort);
}
extern "C" __declspec(dllexport) int MPMOpen()
{
    return csharp->MPMOpen()? 1 : 0;
}
extern "C" __declspec(dllexport) void MPMClose()
{
    csharp->MPMClose();
}
//extern "C" __declspec(dllexport) BSTR MPMGetSerialNumber()
//{
//    return csharp->MPMGetSerialNumber();
//}
extern "C" __declspec(dllexport) int MPMSetChannel(int channelIndex)
{
    return csharp->MPMSetChannel(channelIndex)? 1 : 0;
}
extern "C" __declspec(dllexport) int MPMIsSwitching()
{
    return csharp->MPMIsSwitching()? 1 : 0;
}

//스펙트로미터 함수
extern "C" __declspec(dllexport) void Close(int spectrometerIndex)
{
    csharp->Close(spectrometerIndex);
}
extern "C" __declspec(dllexport) void CloseAll()
{
    csharp->CloseAll();
}
extern "C" __declspec(dllexport) int GetBoxcarWidth(int spectrometerIndex)
{
    return csharp->GetBoxcarWidth(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetContinuousStrobeEnable(int spectrometerIndex)
{
    return csharp->GetContinuousStrobeEnable(spectrometerIndex)? 1 : 0;
}
extern "C" __declspec(dllexport) int GetContinuousStrobePeriod(int spectrometerIndex)
{
    return csharp->GetContinuousStrobePeriod(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetElectricDarkEnable(int spectrometerIndex)
{
    return csharp->GetElectricDarkEnable(spectrometerIndex)? 1 : 0;
}

extern "C" __declspec(dllexport) double* GetFormatedSpectrum(int spectrometerIndex)
{
    if (nullptr != g_dData2)
        delete[] g_dData2;

    SAFEARRAY* saData = csharp->GetFormatedSpectrum(spectrometerIndex);
    
    if (nullptr == saData)
        return nullptr;
    
    if (1 >= saData->rgsabound->cElements)
        return nullptr;

    double HUGEP* pdFreq;
    HRESULT hr = SafeArrayAccessData(saData, (void HUGEP * FAR*) & pdFreq);
    if (SUCCEEDED(hr))
    {
        g_dData2 = new double[saData->rgsabound->cElements];
        for (DWORD i = 0; i < saData->rgsabound->cElements; i++)
        {
            
            g_dData2[i] = *pdFreq++;
            
           // std::cout << g_dData2[i] << std::endl;
        }
        SafeArrayUnaccessData(saData);
    }
    else
        return nullptr;

    SafeArrayDestroy(saData); // 이거 작업안해줘도 될지도????
    saData = NULL;
    return g_dData2;
}

extern "C" __declspec(dllexport) int GetGPIOMuxBit(int spectrometerIndex)
{
    return csharp->GetGPIOMuxBit(spectrometerIndex);
}
extern "C" __declspec(dllexport) int GetGPIOOutputEnable(int spectrometerIndex)
{
    return csharp->GetGPIOOutputEnable(spectrometerIndex);
}
extern "C" __declspec(dllexport) int GetGPIOValue(int spectrometerIndex)
{
    return csharp->GetGPIOValue(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetIntegrationTime(int spectrometerIndex)
{
    return (int)csharp->GetIntegrationTime(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetIntegrationTimeMaximun(int spectrometerIndex)
{
    return (int)csharp->GetIntegrationTimeMaximun(spectrometerIndex);
}
extern "C" __declspec(dllexport) int GetIntegrationTimeMinimun(int spectrometerIndex)
{
    return (int)csharp->GetIntegrationTimeMinimun(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetMaxBoxcarWidth(int spectrometerIndex)
{
    return csharp->GetMaxBoxcarWidth(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetMaxScansToAverage(int spectrometerIndex)
{
    return csharp->GetMaxScansToAverage(spectrometerIndex);
}

extern "C" __declspec(dllexport) double* GetNonlinearityCofficient(int spectrometerIndex)
{
    if (nullptr != g_dData)
        delete[] g_dData;

    SAFEARRAY* saData = csharp->GetNonlinearityCofficient(spectrometerIndex);

    if (nullptr == saData)
        return nullptr;

    if (1 >= saData->rgsabound->cElements)
        return nullptr;

    double HUGEP* pdFreq;
    HRESULT hr = SafeArrayAccessData(saData, (void HUGEP * FAR*) & pdFreq);
    if (SUCCEEDED(hr))
    {
        g_dData = new double[saData->rgsabound->cElements];
        for (DWORD i = 0; i < saData->rgsabound->cElements; i++)
        {
            g_dData[i] = *pdFreq++;
        }
        SafeArrayUnaccessData(saData);
    }
    else
        return nullptr;

    SafeArrayDestroy(saData); // 이거 작업안해줘도 될지도????
    saData = NULL;
    return g_dData;    
}

extern "C" __declspec(dllexport) int GetNonlinearityCorrectionEnabled(int spectrometerIndex)
{
    return csharp->GetNonlinearityCorrectionEnabled(spectrometerIndex)? 1 : 0;
}

extern "C" __declspec(dllexport) int GetNumberOfDarkPixel(int spectrometerIndex)
{
    return csharp->GetNumberOfDarkPixel(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetNumberOfPixels(int spectrometerIndex)
{
    return csharp->GetNumberOfPixels(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetScansToAverage(int spectrometerIndex)
{
    return csharp->GetScansToAverage(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetSingleStrobeHigh(int spectrometerIndex)
{
    return csharp->GetSingleStrobeHigh(spectrometerIndex);
}
extern "C" __declspec(dllexport) int GetSingleStrobeLow(int spectrometerIndex)
{
    return csharp->GetSingleStrobeLow(spectrometerIndex);
}

extern "C" __declspec(dllexport) int GetStobeEnable(int spectrometerIndex)
{
    return csharp->GetStobeEnable(spectrometerIndex)? 1 : 0;
}

extern "C" __declspec(dllexport) double* GetStrayLightCofficient(int spectrometerIndex)
{
    if (nullptr != g_dData)
        delete[] g_dData;

    SAFEARRAY* saData = csharp->GetStrayLightCofficient(spectrometerIndex);

    if (nullptr == saData)
        return nullptr;

    if (1 >= saData->rgsabound->cElements)
        return nullptr;

    double HUGEP* pdFreq;
    HRESULT hr = SafeArrayAccessData(saData, (void HUGEP * FAR*) & pdFreq);
    if (SUCCEEDED(hr))
    {
        g_dData = new double[saData->rgsabound->cElements];
        for (DWORD i = 0; i < saData->rgsabound->cElements; i++)
        {
            g_dData[i] = *pdFreq++;
        }
        SafeArrayUnaccessData(saData);
    }
    else
        return nullptr;

    SafeArrayDestroy(saData); // 이거 작업안해줘도 될지도????
    saData = NULL;
    return g_dData;    
}

extern "C" __declspec(dllexport) int GetTriggerMode(int spectrometerIndex)
{
    return csharp->GetTriggerMode(spectrometerIndex);
}

extern "C" __declspec(dllexport) double* GetWavelength(int spectrometerIndex)
{
    if (nullptr != g_dData)
        delete[] g_dData;

    SAFEARRAY* saData = csharp->GetWavelength(spectrometerIndex);

    if (nullptr == saData)
        return nullptr;

    if (1 >= saData->rgsabound->cElements)
        return nullptr;

    double HUGEP* pdFreq;
    HRESULT hr = SafeArrayAccessData(saData, (void HUGEP * FAR*) & pdFreq);
    if (SUCCEEDED(hr))
    {
        g_dData = new double[saData->rgsabound->cElements];
        for (DWORD i = 0; i < saData->rgsabound->cElements; i++)
        {
            g_dData[i] = *pdFreq++;
        }
        SafeArrayUnaccessData(saData);
    }
    else
        return nullptr;

    SafeArrayDestroy(saData); // 이거 작업안해줘도 될지도????
    saData = NULL;
    return g_dData;    
}

extern "C" __declspec(dllexport) double* GetWavelengthCofficient(int spectrometerIndex)
{
    if (nullptr != g_dData)
        delete[] g_dData;

    SAFEARRAY* saData = csharp->GetWavelengthCofficient(spectrometerIndex);

    if (nullptr == saData)
        return nullptr;

    if (1 >= saData->rgsabound->cElements)
        return nullptr;

    double HUGEP* pdFreq;
    HRESULT hr = SafeArrayAccessData(saData, (void HUGEP * FAR*) & pdFreq);
    if (SUCCEEDED(hr))
    {
        g_dData = new double[saData->rgsabound->cElements];
        for (DWORD i = 0; i < saData->rgsabound->cElements; i++)
        {
            g_dData[i] = *pdFreq++;
        }
        SafeArrayUnaccessData(saData);
    }
    else
        return nullptr;

    SafeArrayDestroy(saData); // 이거 작업안해줘도 될지도????
    saData = NULL;
    return g_dData;    
}
extern "C" __declspec(dllexport) int IsSaturated(int spectrometerIndex)
{
    return csharp->IsSaturated(spectrometerIndex)? 1 : 0;
}

extern "C" __declspec(dllexport) int OpenAllSpectrometers()
{
    return (int)csharp->OpenAllSpectrometers();
}

extern "C" __declspec(dllexport) byte* ReadI2cBus(int spectrometerIndex, byte address)
{
    if (nullptr != g_byData)
        delete[] g_byData;

    SAFEARRAY* saData = csharp->ReadI2cBus(spectrometerIndex, address);

    if (nullptr == saData)
        return nullptr;

    if (1 >= saData->rgsabound->cElements)
        return nullptr;

    byte HUGEP* pbFreq;
    HRESULT hr = SafeArrayAccessData(saData, (void HUGEP * FAR*) & pbFreq);
    if (SUCCEEDED(hr))
    {
        g_byData = new byte[saData->rgsabound->cElements];
        for (DWORD i = 0; i < saData->rgsabound->cElements; i++)
        {
            g_byData[i] = *pbFreq++;
        }
        SafeArrayUnaccessData(saData);
    }
    else
        return nullptr;

    SafeArrayDestroy(saData); // 이거 작업안해줘도 될지도????
    saData = NULL;
    return g_byData;
}

extern "C" __declspec(dllexport) int SetBoxcarWidth(int spectrometerIndex, int val)
{
    return csharp->SetBoxcarWidth(spectrometerIndex, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetContinuousStrobeEnable(int spectrometerIndex, int enable)
{
    return csharp->SetContinuousStrobeEnable(spectrometerIndex, enable)? 1 : 0;
}
extern "C" __declspec(dllexport) int SetContinuousStrobePeriod(int spectrometerIndex, int value)
{
    return csharp->SetContinuousStrobePeriod(spectrometerIndex, value)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetElectricDarkEnable(int spectrometerIndex, int val)
{
    return csharp->SetElectricDarkEnable(spectrometerIndex, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetGPIOMuxBit(int spectrometerIndex, int type)
{
    return csharp->SetGPIOMuxBit(spectrometerIndex, type)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetGPIOOutputEnable(int spectrometerIndex, int enable)
{
    return csharp->SetGPIOOutputEnable(spectrometerIndex, enable)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetGPIOValue(int spectrometerIndex, int val)
{
    return csharp->SetGPIOValue(spectrometerIndex, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetIntegrationTime(int spectrometerIndex, int integrationTime)
{
    return csharp->SetIntegrationTime(spectrometerIndex, integrationTime) ? 1 : 0;
}

extern "C" __declspec(dllexport) int SetNonlinearityCofficient(int spectrometerIndex, int slot, double val)
{
    return csharp->SetNonlinearityCofficient(spectrometerIndex, slot, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetNonlinearityCorrectionEnabled(int spectrometerIndex, int val)
{
    return csharp->SetNonlinearityCorrectionEnabled(spectrometerIndex, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetScansToAverage(int spectrometerIndex, int val)
{
    return csharp->SetScansToAverage(spectrometerIndex, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetSingleStrobeHigh(int spectrometerIndex, int value)
{
    return csharp->SetSingleStrobeHigh(spectrometerIndex, value)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetSingleStrobeLow(int spectrometerIndex, int value)
{
    return csharp->SetSingleStrobeLow(spectrometerIndex, value)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetStrayLightCofficient(int spectrometerIndex, int slot, double val)
{
    return csharp->SetStrayLightCofficient(spectrometerIndex, slot, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetStrobeEnable(int spectrometerIndex, int enable)
{
    return csharp->SetStrobeEnable(spectrometerIndex, enable)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetTriggerMode(int spectrometerIndex, int val)
{
    return csharp->SetTriggerMode(spectrometerIndex, val)? 1 : 0;
}

extern "C" __declspec(dllexport) int SetWavelengthCofficient(int spectrometerIndex, int slot, double val)
{
    return csharp->SetWavelengthCofficient(spectrometerIndex, slot, val)? 1 : 0;
}

EXPORT int __stdcall serialConnect(int nPort)
{
	CSerialPort _serial;
	CString str;
	if (nPort < 10)
		str.Format(L"COM%d", nPort);
	else
		str.Format(L"\\\\.\\COM%d", nPort);
	_serial.SetCommunicationTimeouts(1, 1, 1, 1, 1);
	if (_serial.OpenPort(str))
	{
		std::cout << "Port Connect Success" << std::endl;
		_serial.ConfigurePort(CBR_115200, 8, FALSE, NOPARITY, ONESTOPBIT);
		_serial.SetCommunicationTimeouts(1, 1, 1, 1, 1);
		BYTE* pByte = new BYTE[512];
		/*if (_serial.ReadByte(pByte, 1))
		{
			std::cout << "Receive OK" << std::endl;
		}*/
		_serial.ClosePort();
	}
	else {
		nPort = -1;
		std::cout << "Port Connect Fail" << std::endl;
	}

	return nPort;
}

int main()
{
    //ICallClass *csharp = NULL;
    //std::cout << "2!\n";
    //CoInitialize(NULL);
    //g_hr = CoCreateInstance(CLSID_Wgstest, NULL, CLSCTX_INPROC_SERVER, IID_ICallClass, reinterpret_cast<void**>(&csharp));
    //if (SUCCEEDED(g_hr))
    {
        int bResult = OCR_Start();
        //MPMStart(4);
        
        int nn = OpenAllSpectrometers();
        nn = SetIntegrationTime(0, 100000);
        nn = nn;
    }
    
    //int bResult = OCR_Start();
    //
    //if (bResult)
    //{
    //    double* ppp = GetFormatedSpectrum(0);
    //    for (int i = 0; i < 2048; i++)
    //    {
    //        std::string sss = std::to_string(ppp[i]);
    //        std::cout << sss + "\n";
    //    }
    //}
    //else
    //{
    //
    //}

    //std::cout << "Hello World!\n";
    //ICallClass *csharp = NULL;
    //std::cout << "2!\n";
    //CoInitialize(NULL);
    //HRESULT hr = CoCreateInstance(CLSID_Wgstest, NULL, CLSCTX_INPROC_SERVER, IID_ICallClass, reinterpret_cast<void**>(&csharp));
    //if (SUCCEEDED(hr)){
    //	std::cout << "성공!\n";
    //	csharp->createOCR();
    //	csharp->setmsg("하하하123");
    //	csharp->test();
    //	int n = csharp->GetBoxcarWidth(0);
    //	std::cout << "성공!\n";
    //}
    //std::cout << "End!\n";
}

// 프로그램 실행: <Ctrl+F5> 또는 [디버그] > [디버깅하지 않고 시작] 메뉴
// 프로그램 디버그: <F5> 키 또는 [디버그] > [디버깅 시작] 메뉴

// 시작을 위한 팁: 
//   1. [솔루션 탐색기] 창을 사용하여 파일을 추가/관리합니다.
//   2. [팀 탐색기] 창을 사용하여 소스 제어에 연결합니다.
//   3. [출력] 창을 사용하여 빌드 출력 및 기타 메시지를 확인합니다.
//   4. [오류 목록] 창을 사용하여 오류를 봅니다.
//   5. [프로젝트] > [새 항목 추가]로 이동하여 새 코드 파일을 만들거나, [프로젝트] > [기존 항목 추가]로 이동하여 기존 코드 파일을 프로젝트에 추가합니다.
//   6. 나중에 이 프로젝트를 다시 열려면 [파일] > [열기] > [프로젝트]로 이동하고 .sln 파일을 선택합니다.
