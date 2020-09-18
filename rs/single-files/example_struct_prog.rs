#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

// reference allows for us to BORROW
// rather than TAKE OWNERSHIP
// since otherwise we would need to return the rectangle
impl Rectangle {
    // self can be:
    // - taken ownership of
    //     - rare, usually used when the struct is transformed, and the caller should not use the
    //     original instance after transformation
    // - borrowed immutably (done here)
    // - borrowed mutably

    // these functions are methods, because
    // they work on self.
    // functions not working on self are 'associated functions'
    //
    // they are usually used as constructors, since a struct needn't
    // exist for them to work.
    //
    // such an example is String::from
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn can_hold(&self, rectangle: &Rectangle) -> bool {
        self.width >= rectangle.width && self.height >= rectangle.height
    }

    // this is an example of an associated function
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    let rect2 = Rectangle {
        width: 10,
        height: 40,
    };

    let rect3 = Rectangle {
        width: 60,
        height: 45,
    };

    let sq1 = Rectangle::square(50);

    println!("rect1 is {:#?}", rect1);
    println!("rect1 has area: {}", rect1.area());

    println!("sq1 has area: {}", sq1.area());

    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3));
}
