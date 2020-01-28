/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

/**
 *
 * @author melvinabraham
 */
public class Procedure {
   private String DRG = "";
   private int providerId = 0;
   private String providerName = "";
   private String providerStreetAddress = "";
   private String providerCity = "";
   private String providerState = "";
   private int providerZipCode = 0;
   private String HRR = "";
   private float totalPayments = 0;
   
   public Procedure(String DRG, int providerId, String providerName, String providerStreetAddress, String providerCity, String providerState, int providerZipCode, String HRR, float totalPayments) { 
       this.DRG = DRG;
       this.providerId = providerId;
       this.providerName = providerName;
       this.providerStreetAddress = providerStreetAddress;
       this.providerCity = providerCity;
       this.providerState = providerState;
       this.providerZipCode = providerZipCode;
       this.HRR = HRR;
       this.totalPayments = totalPayments;
       
   }

   public void setDRG(String DRG)
   {
       this.DRG = DRG;
   }
   public void setProviderId(int providerId )
   {
       this.providerId = providerId;
   }
   public void setProviderName(String providerName)
   {
       this.providerName = providerName;
   }
   public void setProviderStreetAddress(String providerStreetAddress)
   {
       this.providerStreetAddress= providerStreetAddress;
   }
   public void setProviderCity(String providerCity)
   {
       this.providerCity= providerCity;
   }
   public void setProviderState(String providerState)
   {
       this.providerState= providerState;
   }
   public void setpProviderZipCode(int providerZipCode)
   {
       this.providerZipCode = providerZipCode;
   }
   public void setHRR(String HRR)
   {
       this.HRR = HRR;
   }
   public void setTotalPayments(float totalPayments)
   {
       this.totalPayments = totalPayments;
   }

   
   public String getDRG()
   {
       return DRG;
   }
   public int getProviderId()
   {
       return providerId;
   }
   public String getProviderName()
   {
       return providerName;
   }
   public String getProviderStreetAddress()
   {
       return providerStreetAddress;
   }
   public String getProviderCity()
   {
       return providerCity;
   }
   public String getProviderState()
   {
       return providerState;
   }
   public int getProviderZipCode()
   {
       return providerZipCode;
   }
   public String getHRR()
   {
       return HRR;
   }
   public float getTotalPayments()
   {
       return totalPayments;
   }
}
