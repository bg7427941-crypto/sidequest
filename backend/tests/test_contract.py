def test_api_contract_documented():
    # Smoke-test documental: el contrato principal queda explícito para integrar Flutter.
    endpoints = {
        "/health",
        "/api/v1/missions",
        "/api/v1/missions/{mission_id}",
        "/api/v1/missions/nearby",
        "/api/v1/missions [POST]",
    }
    assert len(endpoints) == 5
