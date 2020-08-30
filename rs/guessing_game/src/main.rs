use rand::Rng;
use std::cmp::Ordering;
use std::io;

// Rng is a "trait" of rand, and must be in scope for our methods
// To determine what traits and methods are needed from a "crate"
// read documentation with "cargo doc --open"

fn main() {
    println!("Guess the number!");
    let secret_number = rand::thread_rng().gen_range(1, 101);
    loop {
        println!("Please input your guess.");

        // let - variable assignment, default immutable
        // mut - indicates can be mutated
        // ::  - indicates static method, impl. on type rather than instance
        // new - common constructor name
        let mut guess = String::new();

        // & - get reference, seems like C?
        // & is an _immutable reference_
        // so &mut is a mutable reference
        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");
        // .expect - a "Result" is returned by IO,
        // we display the error message in expect upon error
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        println!("You guessed: {}", guess);

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
                break;
            }
        }
    }
}
