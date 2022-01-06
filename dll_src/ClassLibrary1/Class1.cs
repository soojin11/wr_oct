using OCR.Components;
using System;
using System.Runtime.InteropServices;


public enum OcrConnectionType
{
    All = -1,
    USB = 0,
    SerialPort = 1,
    Ethernet = 2
}

namespace ClassLibrary1
{
    [Guid("11E56965-2799-417F-97C5-7FFC74863F65")]
    public interface ICallClass
    {
        
        //MPM
        void MPMStart(int nPort);
        int MPMOpen();
        void MPMClose();
        int MPMSetChannel(int channelIndex);
        int MPMIsSwitching();
        
        //OCR
        void Close(int spectrometerIndex);
        void CloseAll();
        int GetBoxcarWidth(int spectrometerIndex);
        int GetContinuousStrobeEnable(int spectrometerIndex);
        int GetContinuousStrobePeriod(int spectrometerIndex);
        int GetElectricDarkEnable(int spectrometerIndex);
        double[] GetFormatedSpectrum(int spectrometerIndex);
        int GetGPIOMuxBit(int spectrometerIndex);
        int GetGPIOOutputEnable(int spectrometerIndex);
        int GetGPIOValue(int spectrometerIndex);
        uint GetIntegrationTime(int spectrometerIndex);
        uint GetIntegrationTimeMaximun(int spectrometerIndex);
        uint GetIntegrationTimeMinimun(int spectrometerIndex);
        int GetMaxBoxcarWidth(int spectrometerIndex);
        int GetMaxScansToAverage(int spectrometerIndex);        
        double[] GetNonlinearityCofficient(int spectrometerIndex);
        int GetNonlinearityCorrectionEnabled(int spectrometerIndex);
        int GetNumberOfDarkPixel(int spectrometerIndex);
        int GetNumberOfPixels(int spectrometerIndex);
        int GetScansToAverage(int spectrometerIndex);
        int GetSingleStrobeHigh(int spectrometerIndex);
        int GetSingleStrobeLow(int spectrometerIndex);
        int GetStobeEnable(int spectrometerIndex);
        double[] GetStrayLightCofficient(int spectrometerIndex);
        int GetTriggerMode(int spectrometerIndex);
        double[] GetWavelength(int spectrometerIndex);
        double[] GetWavelengthCofficient(int spectrometerIndex);
        int IsSaturated(int spectrometerIndex);
        int OpenAllSpectrometers();
        byte[] ReadI2cBus(int spectrometerIndex, byte address);
        int SetBoxcarWidth(int spectrometerIndex, int val);
        int SetContinuousStrobeEnable(int spectrometerIndex, int enable);
        int SetContinuousStrobePeriod(int spectrometerIndex, int value);
        int SetElectricDarkEnable(int spectrometerIndex, int val);
        int SetGPIOMuxBit(int spectrometerIndex, int type);
        int SetGPIOOutputEnable(int spectrometerIndex, int enable);
        int SetGPIOValue(int spectrometerIndex, int val);
        int SetIntegrationTime(int spectrometerIndex, uint integrationTime);
        int SetNonlinearityCofficient(int spectrometerIndex, int slot, double val);
        int SetNonlinearityCorrectionEnabled(int spectrometerIndex, int val);
        int SetScansToAverage(int spectrometerIndex, int val);
        int SetSingleStrobeHigh(int spectrometerIndex, int value);
        int SetSingleStrobeLow(int spectrometerIndex, int value);
        int SetStrayLightCofficient(int spectrometerIndex, int slot, double val);
        int SetStrobeEnable(int spectrometerIndex, int enable);
        int SetTriggerMode(int spectrometerIndex, int val);
        int SetWavelengthCofficient(int spectrometerIndex, int slot, double val);
    }
    [Guid("46A612B2-2563-4043-84C2-A7E3063214C0")]
    public class Wgstest : ICallClass
    {
        public OCR.OCR _wrapper = null;
        public IMultiplexerComponent _mpm;

        public Wgstest()
        {
            _wrapper = new OCR.OCR("C:\\license.lic");
        }
        
        /* MPM2000 함수*/
        public void MPMStart(int nPort)
        {
            string strPort = "COM" + nPort.ToString();
            _mpm = _wrapper.GetMPM2000Component(strPort);
        }
        public int MPMOpen()
        {
            return _mpm.Open() ? 1 : 0;
        }
        public void MPMClose()
        {
            _mpm.Close();
        }
        public int MPMSetChannel(int channelIndex)
        {
            return _mpm.SetChannel(channelIndex) ? 1 : 0; ;
        }
        public int MPMIsSwitching()
        {
            return _mpm.IsSwitching ? 1 : 0; ;
        }

        /*스펙트로미터 함수*/
        public void Close(int spectrometerIndex)
        {
            _wrapper.Close(spectrometerIndex);
        }
        public void CloseAll()
        {            
            _wrapper.CloseAll();
        }
        public int GetBoxcarWidth(int spectrometerIndex)
        {
            return _wrapper.GetBoxcarWidth(spectrometerIndex);
        }
        public int GetContinuousStrobeEnable(int spectrometerIndex)
        {
            return _wrapper.GetContinuousStrobeEnable(spectrometerIndex) ? 1 : 0; ;
        }
        public int GetContinuousStrobePeriod(int spectrometerIndex)
        {
            return _wrapper.GetContinuousStrobePeriod(spectrometerIndex);
        }
        public int GetElectricDarkEnable(int spectrometerIndex)
        {
            return _wrapper.GetElectricDarkEnable(spectrometerIndex) ? 1 : 0; ;
        }
        public double[] GetFormatedSpectrum(int spectrometerIndex)
        {
            //double[] ddd = new double[2048];
            //
            //for(int i = 0; i < 2048; i++)
            //{
            //    ddd[i] = i;
            //}
            //
            //return ddd;
            return _wrapper.GetFormatedSpectrum(spectrometerIndex);
        }
        public int GetGPIOMuxBit(int spectrometerIndex)
        {
            return _wrapper.GetGPIOMuxBit(spectrometerIndex);
        }
        public int GetGPIOOutputEnable(int spectrometerIndex)
        {
            return _wrapper.GetGPIOOutputEnable(spectrometerIndex);
        }
        public int GetGPIOValue(int spectrometerIndex)
        {
            return _wrapper.GetGPIOValue(spectrometerIndex);
        }
        public uint GetIntegrationTime(int spectrometerIndex)
        {
            return _wrapper.GetIntegrationTime(spectrometerIndex);
        }
        public uint GetIntegrationTimeMaximun(int spectrometerIndex)
        {
            return _wrapper.GetIntegrationTimeMaximun(spectrometerIndex);
        }
        public uint GetIntegrationTimeMinimun(int spectrometerIndex)
        {
            return _wrapper.GetIntegrationTimeMinimun(spectrometerIndex);
        }
        public int GetMaxBoxcarWidth(int spectrometerIndex)
        {
            return _wrapper.GetMaxBoxcarWidth(spectrometerIndex);
        }
        public int GetMaxScansToAverage(int spectrometerIndex)
        {
            return _wrapper.GetMaxScansToAverage(spectrometerIndex);
        }
        public double[] GetNonlinearityCofficient(int spectrometerIndex)
        {
            return _wrapper.GetNonlinearityCofficient(spectrometerIndex);
        }
        public int GetNonlinearityCorrectionEnabled(int spectrometerIndex)
        {
            return _wrapper.GetNonlinearityCorrectionEnabled(spectrometerIndex) ? 1 : 0; ;
        }
        public int GetNumberOfDarkPixel(int spectrometerIndex)
        {
            return _wrapper.GetNumberOfDarkPixel(spectrometerIndex);
        }
        public int GetNumberOfPixels(int spectrometerIndex)
        {
            return _wrapper.GetNumberOfPixels(spectrometerIndex);
        }
        public int GetScansToAverage(int spectrometerIndex)
        {
            return _wrapper.GetScansToAverage(spectrometerIndex);
        }
        public int GetSingleStrobeHigh(int spectrometerIndex)
        {
            return _wrapper.GetSingleStrobeHigh(spectrometerIndex);
        }
        public int GetSingleStrobeLow(int spectrometerIndex)
        {
            return _wrapper.GetSingleStrobeLow(spectrometerIndex);
        }
        public int GetStobeEnable(int spectrometerIndex)
        {
            return _wrapper.GetStobeEnable(spectrometerIndex) ? 1 : 0; ;
        }
        public double[] GetStrayLightCofficient(int spectrometerIndex)
        {
            return _wrapper.GetStrayLightCofficient(spectrometerIndex);
        }
        public int GetTriggerMode(int spectrometerIndex)
        {
            return _wrapper.GetTriggerMode(spectrometerIndex);
        }
        public double[] GetWavelength(int spectrometerIndex)
        {
            return _wrapper.GetWavelength(spectrometerIndex);
        }
        public double[] GetWavelengthCofficient(int spectrometerIndex)
        {
            return _wrapper.GetWavelengthCofficient(spectrometerIndex);
        }
        public int IsSaturated(int spectrometerIndex)
        {
            return _wrapper.IsSaturated(spectrometerIndex) ? 1 : 0;
        }
        public int OpenAllSpectrometers()
        {
            return _wrapper.OpenAllSpectrometers();
        }
        public byte[] ReadI2cBus(int spectrometerIndex, byte address)
        {
            return _wrapper.ReadI2cBus(spectrometerIndex, address);
        }
        public int SetBoxcarWidth(int spectrometerIndex, int val)
        {
            return _wrapper.SetBoxcarWidth(spectrometerIndex, val) ? 1 : 0; ;
        }
        public int SetContinuousStrobeEnable(int spectrometerIndex, int enable)
        {
            bool bEnable = false;
            if (1 == enable)
                bEnable = true;
            return _wrapper.SetContinuousStrobeEnable(spectrometerIndex, bEnable) ? 1 : 0;
        }
        public int SetContinuousStrobePeriod(int spectrometerIndex, int value)
        {
            return _wrapper.SetContinuousStrobePeriod(spectrometerIndex, value) ? 1 : 0;
        }
        public int SetElectricDarkEnable(int spectrometerIndex, int val)
        {
            bool bEnable = false;
            if (1 == val)
                bEnable = true;
            return _wrapper.SetElectricDarkEnable(spectrometerIndex, bEnable) ? 1 : 0;
        
        }
        public int SetGPIOMuxBit(int spectrometerIndex, int type)
        {
            return _wrapper.SetGPIOMuxBit(spectrometerIndex, type) ? 1 : 0;
        }
        public int SetGPIOOutputEnable(int spectrometerIndex, int enable)
        {
            bool bEnable = false;
            if (1 == enable)
                bEnable = true;
            return _wrapper.SetGPIOOutputEnable(spectrometerIndex, bEnable) ? 1 : 0;
        }
        public int SetGPIOValue(int spectrometerIndex, int val)
        {
            return _wrapper.SetGPIOValue(spectrometerIndex, val) ? 1 : 0;
        }
        public int SetIntegrationTime(int spectrometerIndex, uint integrationTime)
        {
            return _wrapper.SetIntegrationTime(spectrometerIndex, integrationTime) ? 1 : 0;
        }
        public int SetNonlinearityCofficient(int spectrometerIndex, int slot, double val)
        {
            return _wrapper.SetNonlinearityCofficient(spectrometerIndex, slot, val) ? 1 : 0;
        }
        public int SetNonlinearityCorrectionEnabled(int spectrometerIndex, int val)
        {
            bool bEnable = false;
            if (1 == val)
                bEnable = true;
            return _wrapper.SetNonlinearityCorrectionEnabled(spectrometerIndex, bEnable) ? 1 : 0;
        }
        public int SetScansToAverage(int spectrometerIndex, int val)
        {
            return _wrapper.SetScansToAverage(spectrometerIndex, val) ? 1 : 0;
        }
        public int SetSingleStrobeHigh(int spectrometerIndex, int value)
        {
            return _wrapper.SetSingleStrobeHigh(spectrometerIndex, value) ? 1 : 0;
        }
        public int SetSingleStrobeLow(int spectrometerIndex, int value)
        {
            return _wrapper.SetSingleStrobeLow(spectrometerIndex, value) ? 1 : 0;
        }
        public int SetStrayLightCofficient(int spectrometerIndex, int slot, double val)
        {
            return _wrapper.SetStrayLightCofficient(spectrometerIndex, slot, val) ? 1 : 0;
        }
        public int SetStrobeEnable(int spectrometerIndex, int enable)
        {
            bool bEnable = false;
            if (1 == enable)
                bEnable = true;
            return _wrapper.SetStrobeEnable(spectrometerIndex, bEnable) ? 1 : 0;
        }
        public int SetTriggerMode(int spectrometerIndex, int val)
        {
            return _wrapper.SetTriggerMode(spectrometerIndex, val) ? 1 : 0;
        }
        public int SetWavelengthCofficient(int spectrometerIndex, int slot, double val)
        {
            return _wrapper.SetWavelengthCofficient(spectrometerIndex, slot, val) ? 1 : 0;
        }        
    }

    public class Cdolyu
    {
        public string str { get; set; }
        
        public Cdolyu()
        {
            
        }
    }
}
