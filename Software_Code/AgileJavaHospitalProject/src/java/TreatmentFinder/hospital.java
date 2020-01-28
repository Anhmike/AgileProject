/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

/**
 *
 * @author fengqu
 */

public class hospital {
   private String DRG = "";
   private int providerId = 0;
   private String providerName = "";
   private String providerStreetAddress = "";
   private String providerCity = "";
   private String providerState = "";
   private String providerZipCode = "";
   private String HRR = "";
   private String totalPayments = "";

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
   public void setpProviderZipCode(String providerZipCode)
   {
       this.providerZipCode = providerZipCode;
   }
   public void setHRR(String HRR)
   {
       this.HRR = HRR;
   }
   public void setTotalPayments(String totalPayments)
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
   public String getProviderZipCode()
   {
       return providerZipCode;
   }
   public String getHRR()
   {
       return HRR;
   }
   public String getTotalPayments()
   {
       return totalPayments;
   }
   
   
   
   
   
   
   
}
