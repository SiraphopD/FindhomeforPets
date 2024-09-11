import 'package:googleapis_auth/auth_io.dart';

class AccessFirebaseToken {
  static String fMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "findhomeforpets",
        "private_key_id": "dd222f8d7e86fd9d77836fb22a059f843b92beca",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCa8zFNg95wdAnm\nFON7Qxn+Aqk6IlPtSFqabxpU0xJ6/bZQt4lZ5PgRXk7AbANpmGUlObN6NLkEITrD\nBp1IBib1Y3fufTUnUoApZQYWkuwUn6P/S5G5ROngFSLTStwd6lTpFxDO7G9kJ2v6\nG5DWWw8C5KQkwQOf1rgYam20zspn0n5r8czz87j6hmj994IZbKznaqTYr1V1PyiM\nhhf9BJRF7CVln72I4RPR8MUhwtDsPt/qqFD5CYg23P5dYmvl1mLRiII19+3nILJ6\nROZ3+yMTUjlHq1Z/QNfoE3598uEF1Nt0Bv3YpbM62y700Kgfiqs7MZJjCuWHEnAA\n/gbL1QW9AgMBAAECggEAAjzdmw2soCKhxEx238rttXlva2P7zXlUZBbagj9g5bJR\n7aUbJAIhOHXhyv9X5n7OvSSVb+OSbJKmZKEl6IMudJOeM6YrNSdsR8zDD+LJQMNU\nOzBinnYn5/ZeLk24/iO4XENMmQnDtfSL54XBVkJH5jDE9xhdSUkUUJsQp7P1Y93S\nzY80hgeiSgAmqmxnTdZsYvN5PPFuSxHD4PWF7f1oTpeQ0y8J4KUTaDXI37jhJbWg\nBN9/4kUqQQ5kver7eV/FEL4fSnD/RhJaBZWTFMAmAz4c+9fBJxot7sOZgZWEl27X\nvpn9xo3YHbZQsTCFSPIhyXadDQnvAetxw/D+/ovrYQKBgQDK+ixdSb5sgynjlTvA\nNUadcLYgKIC/M4DzfrNldQ44hii9CTi7aL0NgkfPSC/UQWRMT0eg+LJhkZ54aILC\nB9Wq1A8R7qU5BYBvPFqviqfBlMRWPawsStUCmxgfuPfexuhSv9yfIpdVJW550zn+\n4y7xBgo+nrI3r4ufiwJLicCLoQKBgQDDbULVO8P1DtSPl41vxBShC3+YoOJkFUN7\n/IBcATAnJCcSPIICbdc1uaxRkApwOFpWlaexkuOFw4zpTZUbwTiYqAkCIblPUhxq\nuAwZjWbUQlTQmxisdMfBmeTmZvARKGynsEcHXzzhnGd/JaIaatm1CvLKXjUg9Hko\nXfms2eTknQKBgEh93MZchgPfPGCpdbOJ03R7QrBthr3CuTU9dPixO6j4UShiWL6m\nA48Fjnv7PgnCaP3P+rcE20B5b211de2yOp9OKSuwXZXl3x7bIVA8Zvl+FjjuwcT3\n3OeXWKBLwUrxIxwapcK36fBg8/nSdI4RuTwfeh0vNFsq+OS8Es/DnN7BAoGBAJ7w\nnPt5uRz0q9IBC0oMKk70YBkNODL3zEPpj6fEW5pp39EIHyDEntSWJtzLDoJIgsiK\nvLFCawNekJsquwuwsUwO1gzCyskFWhE9kLGzfB9Dt2FV0tJnxBLkC/OLYtJBk2Uq\njAol3gkLwGz7eYSMxHVm6yHFTuZ3jpZTH/4B1RRNAoGAB0iUBLF7MQLcczBcDoj4\nlEgiYjJZ3pFQ92e8QLcrcAXTa+gpYJmGf4eFygJG8umCWXVeTbJtQOIabvi3bEwC\nqh4SMEFuvM08PJU8C7gs89GhHIoDblmNpMAcVWByEOjN4VHmbJrRO2J/NApoBCVi\nad7q1EBJDhjqyhznC2k1p3s=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-17k13@findhomeforpets.iam.gserviceaccount.com",
        "client_id": "100845838787588027213",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-17k13%40findhomeforpets.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      [fMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
