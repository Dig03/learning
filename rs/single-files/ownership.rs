fn main() {
    // string literals, being non-immutable, can be optimised by constant storage
    // this string _is_ mutable, and therefore doesn't benefit
    let mut s = String::from("Hello, ");
    s.push_str("world!");
    println!("{}", s);

    /*
     * memory is automatically returned once a variable goes out of scope
     * ```
     * {
     *     let mut s = String::from("example");
     * }
     * ```
     *
     * Once we leave scope at '}', rust calls a type's "drop" function to
     * free the memory up.
     *
     * This is sometimes called RAII (as in C++).
     */

    {
        let s1 = String::from("test");
        let s2 = s1; // after this line 's1' has been borrowed by 's2'
                     // the rust implementation no longer considers it
                     // valid. if 's1' is used again it will trigger a
                     // compiler error.
                     // This is because if both s1 and s2 were freed
                     // there would be a double-free error.
                     //
                     // So effectively,
                     // s1 = < memory alloc object >
                     // s2 = s1
                     // s1 has now 'moved' to s2, since s1 is now unusable.
                     //
                     // Rust will never automatically deep copy data.
                     // Automatic copying can be assumed to be inexpensive
                     // in runtime... since it's basically just moving.

        // After all of the above. If we _DO_ want a deep copy, you use .clone()

        let mut s3 = s2.clone();
        s3.push_str(" testy");

        println!("{}", s2);
        println!("{}", s3);
    }

    // Despite all of this, stack-only data is obviously copied, since it
    // has a known size at compile time and can be accounted for, e.g.

    let x = 2;
    let y = x;

    // y is now simply equal to x at that point in time, no referencing,
    // just two separately stack-allocated integers.
    // i.e., no difference with 'deep' versus 'shallow' copies here.
    //
    // A trait called "Copy" allows for such stack based copying,
    // but is mutually exclusive with the "Drop" trait needed for RAII.
    //
    // Types with the "Copy" trait include:
    // - integer types
    // - bool
    // - floating point types
    // - char
    // - tuples, if they only consist of Copy types

    println!("{}", x + y);

    let string = String::from("test");

    takes_ownership(string);

    let mut my_string = String::from("Gives");
    my_string = gives_ownership(my_string);
    takes_ownership(my_string);
    // my_string can't be used after this

    println!("{}", makes_copy(x));

    // So, thus far, ownership rules are:
    // A function accepting the variable takes ownership.
    // A function returning the variable gives ownership.
    //
    // The problem is: if a function takes a lot of
    // variables it must return them all again in a tuple
    // in order to maintain ownership. This is too ceremonial!
    //
    // Therefore rust has _references_.

    let mut the_string = String::from("Takes");
    takes_reference(&mut the_string);
    // WARNING: you can only have _one_ current mutable reference per variable
    // in scope.
    // This is because of the process of 'borrowing'. A reference 'borrows', that
    // which is still borrowed cannot be borrowed again.
    // Since immutable references also borrow, you can only have _either_ a mutable
    // or immutable reference, but not both.
    //
    // You _can_ have multiple immutable references however, since the fact they
    // cannot modify prevents a data-race.
    takes_ownership(the_string);

    // The '&' syntax creates a reference.
    // '&' is an immutable reference
    // '&mut' is a mutable reference
    //
    // A reference _refers_ to the value it is built from,
    // but does not _own_ it. Thus when a reference is dropped
    // it doesn't cause the referred variable to be dropped.

    // if a function returns a dangling pointer, i.e.
    // fn dangle() -> &String {
    //     let s = String::from("hello");
    //     &s
    //  }
    //
    //  It will produce a compiler error, since it value
    //  is not borrowed, it just drops out of scope.
    //
    // fn no_dangle() -> String {
    //     let s = String::from("hello");
    //     s
    // }
    // Writing the function like this solves the issue, since ownership
    // is 'given' as before, the variable is supplied directly, ownership
    // is transferred to the above scope.

    // Finally: the rules of references
    // - at any time: either one mutable, or any number of immutable references can exist
    // - references must always be valid

    // So, what if we want a function to return the first word in a string?
    // We need another ownership-less type: the Slice
    //
    // You can take a slice by taking a reference in the usual way, but
    // appending bounds, e.g.
    
    let another_string = String::from("Hello, world!");
    let hello = &another_string[..5];
    let world = &another_string[7..12];

    println!("{}", hello);
    println!("{}", world);
    
    // To return a string slice from a function, use the type '&str'
    // Using slices to get 'first words' ensures consistency,
    // as 'mutable borrows' (or functions changing the string)
    // will invalidate all slices
    // e.g., obtaining a slice and then clearing the originating
    // string produces a compile-time error.
    //
    // '&str' is a superset containing all values of type '&String'
    //
    // this is because '&String' is 'reference to type String' (general)
    //
    // but '&str' is 'reference to a string Slice' since all '&Strings' can be string slices with
    // full size, it ends up being a more vague type, leading to the signature for first_word
    //
    // fn first_word(s: &str) -> &str
    // therefore, with a String, you simply supply &s[..], allowing for a more general API
    // also important note: string literals have type &str
    //
    // Slices exist for all types, a slice of an i32 array is '&[i32]'
}

fn takes_ownership(string: String) {
    // this function will take ownership of the string passed to it,
    // and it will no longer be able to be referenced in the scope
    // above it.
    // string will be dropped when we leave this scope.
    // i.e. it produces the same borrow error as reassignment from before

    println!("{}", string);
}

fn makes_copy(i: i32) -> i32 {
    // i32 is copy, therefore this creates a copy
    i + 1
}

fn gives_ownership(mut string: String) -> String {
    // This function takes ownership and then gives it back!
    // If it just created a string ex nihilo, then it would
    // also transfer ownership to the scope above.

    string.push_str(" ownership!");
    string
}

fn takes_reference(s: &mut String) {
    s.push_str(" reference!");
}
