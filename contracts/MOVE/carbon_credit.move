module exampleAddress::carbon_credit {
    use std::signer;
    use supra_framework::supra_coin;
    use supra_framework::coin;

    public entry fun transfer_credits(sender: &signer, recipient: address, amount: u64) {
        coin::transfer<supra_coin::SupraCoin>(sender, recipient, amount);
    }

    #[view]
    public fun get_balance(user: address): u64 {
        coin::balance<supra_coin::SupraCoin>(user)
    }
}
