struct Container(i32, i32);

// A trait which checks if 2 items are stored inside of container.
// Also retrieves first or last value.
trait Contains {
    // Define generic types here which methods will be able to utilize.
    type A;
    type B;

    fn contains(&self, _: &Self::A, _: &Self::B) -> bool;
    fn first(&self) -> i32;
    fn last(&self) -> i32;
    fn a(&self) -> Self::A;
}

impl Contains for Container {
    // Specify what types `A` and `B` are. If the `input` type
    // is `Container(i32, i32)`, the `output` types are determined
    // as `i32` and `i32`.
    type A = i32;
    type B = i32;

    // `&Self::A` and `&Self::B` are also valid here.
    fn contains(&self, number_1: &i32, number_2: &i32) -> bool {
        (&self.0 == number_1) && (&self.1 == number_2)
    }
    // Grab the first number.
    fn first(&self) -> i32 {
        self.0
    }

    // Grab the last number.
    fn last(&self) -> i32 {
        self.1
    }

    fn a(&self) -> i32 {
        self.0
    }
}

fn difference<C: Contains>(container: &C) -> i32 {
    container.last() - container.first()
}

fn get_a<C: Contains>(container: &C) -> C::A {
    container.a()
}

trait TraitWithParams<A, B, Z1 = f32, Z2 = f64, const N: i8 = 12> {
    type Output;

    fn get_output(&self) -> Self::Output;
}

impl<T> TraitWithParams<i32, T, bool, T> for Container {
    type Output = (i32, i32);

    fn get_output(&self) -> (i32, i32) {
        (self.0, self.1)
    }
}

fn get_output<C: TraitWithParams<i32, i64, bool, i64>>(container: &C) -> C::Output {
    container.get_output()
}

fn main() {
    let number_1 = 3;
    let number_2 = 10;

    let container = Container(number_1, number_2);

    println!(
        "Does container contain {} and {}: {}",
        &number_1,
        &number_2,
        container.contains(&number_1, &number_2)
    );
    println!("First number: {}", container.first());
    println!("Last number: {}", container.last());

    println!("The difference is: {}", difference(&container));

    println!("Get output.0: {}", get_output(&container).0);
}
