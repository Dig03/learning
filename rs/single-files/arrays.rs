fn main() {
    let a = [1, 2, 3, 4, 5];

    // array type decl: [<type>, <size>]
    let b: [i32; 2] = [1, 2];

    // repeated initialisation (e.g. five threes)
    let c = [3; 5];

    // indexing of arrays is the usual
    let first = a[0];
    let second = a[1];

    println!(
        "First and second elements of a, respectively, are: {}, {}",
        first, second
    );

    // out-of-bounds indexing will be caught by a runtime error, also a compiler error, apparently
}
