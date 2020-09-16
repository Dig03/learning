fn main() {
    println!("Hello, world!");
    /*
     * This
     * is
     * a
     * big
     * ol
     * comment,
     *
     *
     * it keeps going,
     *
     * until
     * you
     * close
     * it
     *
     *
     * ...
     *
     * ...
     */
    another_func();
    another_arg_func(5);
    println!("{}", mathsy_func(2, 2));
}

fn another_func() {
    println!("AAAAAAA");
}

fn another_arg_func(x: i32) {
    println!("AAA ... {} ... AAA", x);
}

fn mathsy_func(x: i32, y: i32) -> i32 {
    // this returns the below value
    (x + y) * (x + y)
}
