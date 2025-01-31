const App = {
  account: "",
  supraSDK: null,

  load: async () => {
    console.log("Connecting to Supra...");
    await App.connectWallet();
    await App.loadContracts();
  },

  connectWallet: async () => {
    try {
      // Connect user wallet using Supra SDK
      App.supraSDK = await SupraSDK.connect();
      App.account = App.supraSDK.getAccount();
      console.log("Connected:", App.account);
    } catch (error) {
      console.error("Connection failed", error);
      alert("Failed to connect to Supra Wallet.");
    }
  },

  loadContracts: async () => {
    try {
        // Replace these with actual deployment addresses
        const userAuthAddress = "0x123...";  
        const emissionAddress = "0x456...";
        const carbonCreditAddress = "0x789...";
        const kycAddress = "0xabc...";

        // Load deployed contracts using Supra SDK
        App.contracts = {
            user_auth: App.supraSDK.getContract(userAuthAddress, "supra::user_auth"),
            emission: App.supraSDK.getContract(emissionAddress, "supra::emission"),
            carbon_credit: App.supraSDK.getContract(carbonCreditAddress, "supra::carbon_credit"),
            kyc: App.supraSDK.getContract(kycAddress, "supra::kyc"),
        };

        console.log("Contracts loaded successfully!");
    } catch (error) {
        console.error("Error loading contracts:", error);
    }
},


  registerUser: async () => {
    const name = document.getElementById("name").value;
    const role = document.getElementById("role").value;
    const authority = document.getElementById("authority").value;

    try {
      await App.contracts.user_auth.execute("register_user", [App.account, name, role, authority]);
      alert("User registered successfully!");
    } catch (error) {
      console.error("Error registering user:", error);
      alert("Registration failed.");
    }
  },

  markEmission: async () => {
    const co2 = document.getElementById("co2").value;
    const date = document.getElementById("date").value;

    try {
      await App.contracts.emission.execute("record_emission", [App.account, parseInt(co2), date]);
      alert("Emission recorded successfully!");
    } catch (error) {
      console.error("Error recording emission:", error);
      alert("Emission recording failed.");
    }
  },

  transferCredits: async () => {
    const recipient = document.getElementById("recipient").value;
    const amount = document.getElementById("amount").value;

    try {
      await App.contracts.carbon_credit.execute("transfer_credits", [App.account, recipient, parseInt(amount)]);
      alert("Credits transferred successfully!");
    } catch (error) {
      console.error("Error transferring credits:", error);
      alert("Transfer failed.");
    }
  },
};

// Initialize the app when the page loads
window.onload = () => {
  App.load();
};
