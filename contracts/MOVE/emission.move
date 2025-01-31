module exampleAddress::emission {
    use std::signer;
    use std::vector;
    use std::option;

    struct EmissionData has key, copy, drop, store {
        user: address,
        co2: u64,
        date: vector<u8>,
    }

    /// Function to record emissions
    public entry fun record_emission(account: &signer, co2: u64, date: vector<u8>) {
        move_to(account, EmissionData { 
            user: signer::address_of(account), 
            co2, 
            date 
        });
    }

    /// Function to get emission data
    #[view]
    public fun get_emission(user: address): option::Option<EmissionData> acquires EmissionData {
        if (exists<EmissionData>(user)) {
            let data = borrow_global<EmissionData>(user);
            option::some(EmissionData { user: data.user, co2: data.co2, date: data.date })
        } else {
            option::none<EmissionData>()
        }
    }
}
