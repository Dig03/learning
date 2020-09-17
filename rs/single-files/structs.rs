fn main() {
    let user1 = User {
        email: String::from("test@test.com"),
        username: String::from("test"),
        active: true,
        sign_in_count: 1,
    };

    println!("{}", user1.email);

    // A struct is either wholly immutable, or wholly mutable.

    let user2 = build_user(String::from("test2@test.com"), String::from("test2"));
    display_user(&user2);

    // struct update syntax
    // all undeclared fields are copied from user2
    let user3 = User {
        email: String::from("test3@test.com"),
        username: String::from("test3"),
        ..user2
    };

    println!();
    display_user(&user3);

    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);
    
    display_color(&black);
    display_point(&origin);
}

fn display_point(point: &Point) {
    println!("({}, {}, {})", point.0, point.1, point.2);
}

fn display_color(color: &Color) {
    println!("R: {}, G: {}, B: {}", color.0, color.1, color.2);
}

fn display_user(user: &User) {
    println!(
        "email: {}\n\
        username: {}\n\
        active: {}\n\
        sign_in_count: {}",
        user.email, user.username, user.active, user.sign_in_count
    );
}

fn build_user(email: String, username: String) -> User {
    // works because parameter names == struct field names
    // a sort of shorthand
    User {
        email,
        username,
        active: true,
        sign_in_count: 1,
    }
}

// usual struct

struct User {
    username: String,
    email: String,
    sign_in_count: u64,
    active: bool,
}

// references in structs must have lifetimes
// otherwise it is a compilation error

// you can also create 'tuple structs'
// these are simply structs with unnamed fields
// useful for creating some rudimentary types:

struct Color(i32, i32, i32);
struct Point(i32, i32, i32);
