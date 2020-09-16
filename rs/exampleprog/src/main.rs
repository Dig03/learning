fn main() {
    println!("32.0F is {}C", f_to_c(32.0));
    println!("32.0C is {}F", c_to_f(32.0));

    let n = 1;
    println!("The {}th fibonacci number is {}", n, fib(n));

    for i in 1..20 {
        println!("{}", fib(i));
    }

    twelve_days();
}

// initial assignments
// generate nth fibonacci number
// print the lyrics of a Christmas Carol (take advantage of repetition)

fn f_to_c(f: f64) -> f64 {
    (f - 32.0) * 5.0 / 9.0
}

fn c_to_f(c: f64) -> f64 {
    c * (9.0 / 5.0) + 32.0
}

fn fib(n: i64) -> i64 {
    let mut result = 0;
    let mut a = 0;
    let mut b = 1;

    for _ in 1..n {
        result = a + b;
        b = a;
        a = result;
    }

    result
}

fn twelve_days() {
    let lyrics = [
        "Twelve drummers drumming",
        "Eleven pipers piping",
        "Ten lords a leaping",
        "Nine ladies dancing",
        "Eight maids a milking",
        "Seven swans a swimming",
        "Six geese a laying",
        "Five gold rings",
        "Four calling birds",
        "Three French hens",
        "Two turtle doves and",
        "A partridge in a pear tree",
    ];

    let days = [
        "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth",
        "tenth", "eleventh", "twelfth",
    ];

    let day_quantity = days.len();

    for i in 0..day_quantity {
        println!(
            "On the {} day of Christmas my true love gave to me",
            days[i]
        );

        for j in day_quantity - 1 - i..day_quantity {
            println!("{}", lyrics[j]);
        }

        println!();
    }
}
