module exampleAddress::user_auth {
    use std::signer;
    use std::vector;
    use std::option;
    use std::account;

    struct User has key, copy, drop, store {
        name: vector<u8>,
        role: vector<u8>,
        authority: vector<u8>,
    }

    public entry fun register_user(
        admin: &signer,
        name: vector<u8>,
        role: vector<u8>,
        authority: vector<u8>
    ) {
        let user = signer::address_of(admin);
        move_to<User>(admin, User { name, role, authority });
    }

    #[view]
    public fun get_user(user: address): option::Option<User> acquires User {
        if (exists<User>(user)) {
            let u_ref = borrow_global<User>(user);  // Borrow the struct
            let User { name, role, authority } = *u_ref;  // Dereference and extract fields
            option::some(User { name, role, authority })  // Return copied values
        } else {
            option::none<User>()
        }
    }
}
