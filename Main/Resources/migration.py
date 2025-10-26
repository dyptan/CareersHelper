

import json
from pathlib import Path

INPUT = Path("dataV3.json")   # adjust if needed
OUTPUT = Path("dataV4.json")  # change to Path("dataV4.json") to keep original

def migrate_luck_to_prestige(data):
    if not isinstance(data, list):
        raise ValueError("Root JSON must be a list of job objects")

    for idx, job in enumerate(data):
        if not isinstance(job, dict):
            continue

        # Get requirements dict
        req = job.get("requirements")
        if isinstance(req, dict) and "luck" in req:
            luck_value = req.get("luck")

            # Set root-level prestige if not already present
            if "prestige" not in job:
                job["prestige"] = luck_value
            else:
                # If prestige already exists, prefer existing value and ignore luck
                pass

            # Remove luck from requirements
            req.pop("luck", None)
            job["version"] = 4
            job["requirements"] = req

    return data

def main():
    # Read
    with INPUT.open("r", encoding="utf-8") as f:
        data = json.load(f)

    # Transform
    data = migrate_luck_to_prestige(data)

    # Write pretty, stable keys, and keep unicode (no ASCII escaping)
    with OUTPUT.open("w", encoding="utf-8") as f:
        json.dump(
            data,
            f,
            ensure_ascii=False,
            indent=2,
            sort_keys=False  # keep original order as much as possible
        )
        f.write("\n")

    print(f"Migrated file written to: {OUTPUT.resolve()}")

if __name__ == "__main__":
    main()
