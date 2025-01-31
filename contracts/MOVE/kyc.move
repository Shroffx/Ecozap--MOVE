module exampleAddress::kyc {
    use std::signer;
    use std::vector;
    use std::string;

    struct KYCData has key, copy, drop, store {
        user: address,
        verified: bool,
    }

    public entry fun verify_user(admin: &signer, user: address) {
        assert!(signer::address_of(admin) == @0x1, 1); // Corrected address comparison
        move_to<KYCData>(admin, KYCData { user, verified: true }); // Correct move_to usage
    }

    #[view]
    public fun is_verified(user: address): bool acquires KYCData { // Correctly keeps `acquires KYCData`
        if (exists<KYCData>(user)) { // Check if user has KYC data
            borrow_global<KYCData>(user).verified
        } else {
            false
        }
    }
}

