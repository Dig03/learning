fn main() {
    println!("Hello!");

    // condition ladder
    if true {
        println!("true is true!!");
    } else if true {
        println!("forever lonely");
    } else {
        println!("even lonelier");
    }

    // loop, while & for provide repetition

    let mut counter = 0;

    // returning a result from an embedded loop
    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    println!("Result is {}", result);

    // continues forever until break
    //loop {
    //    println!("forever");
    //}

    let mut number = 3;

    while number != 0 {
        println!("{}", number);
        number -= 1;
    }
    println!("LIFTOFF!");

    // it is possible to loop over collections with while (like any language), but it is not
    // idiomatic; use for instead for this purpose.
    // further, for provides safety guarantees, particularly with indexing, that while cannot

    let a = [10, 20, 30, 40, 50];

    for element in a.iter() {
        println!("{}", element);
    }

    for i in (1..4).rev() {
        println!("{}", i);
    }
    println!("LIFTOFF!");
}
