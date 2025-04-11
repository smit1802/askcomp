import asyncio
import logging
from app.agents.tools.db_tool import DatabaseTool

# Configure logging
logging.basicConfig(level=logging.INFO)

async def test_queries():
    try:
        db = DatabaseTool()
        
        # Test 1: Search requirements
        print("\n1. Testing requirements search...")
        results = await db.search_requirements("security")
        print(f"Found {len(results)} requirements")
        if results:
            print("\nSample requirement:")
            print(f"Circular: {results[0].get('circular_name', 'N/A')}")
            requirement = results[0].get('requirement_text', 'N/A')
            if requirement:
                print(f"Requirement: {requirement[:200]}...")
        
        # Test 2: Search controls by domain
        print("\n2. Testing controls by domain...")
        controls = await db.get_controls_by_domain("Asset Management")
        print(f"Found {len(controls)} controls")
        if controls:
            print("\nSample control:")
            print(f"Control ID: {controls[0].get('control_id', 'N/A')}")
            objective = controls[0].get('control_objective', 'N/A')
            if objective:
                print(f"Objective: {objective[:200]}...")
            
            # Test 3: Get related requirements for the first control
            control_id = controls[0].get('control_id')
            if control_id:
                print(f"\n3. Testing related requirements for control {control_id}...")
                related = await db.get_related_requirements(control_id)
                print(f"Found {len(related)} related requirements")
                if related:
                    print("\nSample related requirement:")
                    print(f"Circular: {related[0].get('circular_name', 'N/A')}")
                    requirement = related[0].get('requirement_text', 'N/A')
                    if requirement:
                        print(f"Requirement: {requirement[:200]}...")
    
    except Exception as e:
        print(f"Error during testing: {str(e)}")

if __name__ == "__main__":
    asyncio.run(test_queries()) 