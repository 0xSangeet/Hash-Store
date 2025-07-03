module hack::idea_store {

    use std::string;
    use std::vector;
    use std::signer;

    struct Ideas has key {
        messages: vector<string::String>,
    }

    public entry fun init(account: &signer) {
        let addr = signer::address_of(account);
        if (!exists<Ideas>(addr)) {
            move_to(account, Ideas { messages: vector::empty<string::String>() });
        }
    }


    public entry fun submit(account: &signer, idea: string::String) acquires Ideas {
        let addr = signer::address_of(account);
        if (!exists<Ideas>(addr)) {
            move_to(account, Ideas { messages: vector::empty<string::String>() });
        };
        let ideas_ref = borrow_global_mut<Ideas>(addr);
        vector::push_back(&mut ideas_ref.messages, idea);
    }

    #[view]
    public fun get(addr: address): vector<string::String> acquires Ideas {
        assert!(exists<Ideas>(addr), 1);
        let ideas_ref = borrow_global<Ideas>(addr);
        ideas_ref.messages
    }
}
