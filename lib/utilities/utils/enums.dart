
// ignore_for_file: constant_identifier_names

enum Collectionstage {
    EMPTY,
    Lab_Test,
    On_Visit,
    Post_Visit,
    Pre_Visit,
    Verifier_Visit
}

enum Ecosystem {
    Farm,
    Field
}


enum Fieldtype {
    DATE,
    NUMBER,
    TEXT,
    Y_N
}


enum ReadOnlyWhen {
    EMPTY,
    Q_11_NO,
    Q_11_YES,
    Q_12_NO,
    Q_12_YES
}


enum SubLevel {
    ALL_FIELDS,
    EMPTY,
    PER_FIELD
}

enum Status {
    AUTO_SAVED,
    DRAFT,
    SUBMITTED
}