fn main() {
    // packing
    let tup = (500, 6.4, 1);

    // unpacking
    let (x, y, z) = tup;

    // indexing
    let tx = tup.0;
    let ty = tup.1;
    let tz = tup.2;

    println!("The value of y is: {}", y);
    println!("The form of the tuple is ({}, {}, {})", tx, ty, tz);
}
