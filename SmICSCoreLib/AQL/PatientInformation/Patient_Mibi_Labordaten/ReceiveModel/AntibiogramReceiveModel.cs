﻿namespace SmICSCoreLib.AQL.PatientInformation.Patient_Mibi_Labordaten.ReceiveModel
{
    public class AntibiogramReceiveModel
    {
        public string Antibiotikum { get; set; }
        public int Min_Hemmkonzentration { get; set; }
        public string Resistenz { get; set; }
    }
}