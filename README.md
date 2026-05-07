# pwdgenf

- This is a password generator and manager.

## Purpose

- Generate strong password by simple string.
- Generate different passwords by the same string.

## Usage

1. Choose a simple password as Main Password.
2. Click the Add button in the top left corner.
3. Fill in the form. User Name is account name, Platform is the platform of the account, for example, gmail.
4. Click Save button in the top right corner.
5. You can see your account info in main page. Click Detail button.
6. Input your Main Password and click Gen, you will see a string show up. It is the generated password and you can use it as the password for your account.

## Caveat

- The generated password is related to the _User Name_, _Platform_, _Nonce Offset_ and _Main Password_.
- Remember your _Main Password_. _Main Password_ will not be saved.
- You can backup and restore data in settings page.

## Data Flow

```mermaid
flowchart TD
    A["(UserName+Platform+MainPwd).UTF8"];
    B[Hash Value];
    C[Random Number Sequence];
    D[Generated password];

    A -- SHA256 --> B;
    B -- ChaCha20 (Key = Hash Value, Nonce = Slice of Hash Value) --> C;
    C -- Some Algorithm * --> D;
```

### Some Algorithm \*

1. Pick a byte from _Random Number Sequence_, mod 4, to decide character set (up letters, low letters, numbers, special character)
1. Pick a byte from _Random Number Sequence_, mod the length of character set, get a character. (But if the byte is too big, it will be discarded.)
1. All characters join, get generated password.

Related code files: rust/src/api/calculate_password.rs
