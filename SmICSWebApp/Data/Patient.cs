﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SmICSWebApp.Data
{
    public class Patient
    {
        [JsonProperty(PropertyName = "PatientID")]
        public string PatientID { get; set; }

        [JsonProperty(PropertyName = "Zeitpunkt_der_Probenentnahme")]
        public DateTime Probenentnahme { get; set; }
        
        [JsonProperty(PropertyName = "Aufnahme_Datum")]
        public DateTime Aufnahme { get; set; }
        
        [JsonProperty(PropertyName = "Entlastung_cDatum")]
        public DateTime Entlastung { get; set; }

        public Patient() { }
        public Patient(string patientID, DateTime probenentnahme,  DateTime aufnahme, DateTime entlastung) {
            PatientID = patientID;
            Probenentnahme = probenentnahme;
            Aufnahme = aufnahme;
            Entlastung = entlastung;
        }
    }
}
